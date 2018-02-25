module MetaCommit::Extension::MarkdownSupport
  module ContextualAstAccessor
    ELEMENT_TYPE_ANCHOR = :link
    ELEMENT_TYPE_LISTS = :list
    ELEMENT_TYPE_LIST_ITEM = :list_item
    ELEMENT_TYPE_HEADER = :header
    ELEMENT_TYPE_CODE = :code_block
    ELEMENT_TYPE_TEXT = :text
    ELEMENT_TYPE_PARAGRAPH = :paragraph
    ELEMENT_TYPE_IMAGE = :image

    # @param [MetaCommit::Model::ContextualAst] contextual_ast
    # @param [Symbol] type
    # @param [Numeric] line
    # @return [Boolean, Nil]
    def elements_of_type_on_line(contextual_ast, type, line)
      context_nodes_on_line(contextual_ast, line)
          .select {|node| node.element.type == type}
    end

    # @param [Array<MetaCommit::Model::Ast>] nodes
    # @param [Numeric] column
    # @return [Boolean, Nil]
    def element_closest_to(nodes, column)
      nodes
          .select {|node| column.nil? || node.first_column.nil? || node.last_column.nil? || node.first_column <= column}
          .last
    end

    # @param [MetaCommit::Model::ContextualAst] contextual_ast
    # @return [Boolean]
    def anchor_context?(contextual_ast)
      contextual_ast.context_nodes.any? {|node| anchor?(node)}
    end

    # @param [MetaCommit::Extension::MarkdownSupport::Models::Ast] ast
    def anchor?(ast)
      ast.element.type == ELEMENT_TYPE_ANCHOR
    end

    # @param [MetaCommit::Model::ContextualAst] contextual_ast
    # @return [String]
    def anchor_title(contextual_ast)
      anchor = contextual_ast.context_nodes.find {|node| anchor?(node)}
      return anchor.element.first_child.first_child.string_content unless text?(anchor.children.first)
      anchor.element.first_child.string_content
    end

    # @param [MetaCommit::Model::ContextualAst] contextual_ast
    # @return [String]
    def anchor_target(contextual_ast)
      anchor = contextual_ast.context_nodes.find {|node| anchor?(node)}
      anchor.element.url
    end

    # @param [MetaCommit::Model::ContextualAst] contextual_ast
    # @return [Boolean]
    def list_context?(contextual_ast)
      contextual_ast.context_nodes.any? {|node| list?(node)}
    end

    # @param [MetaCommit::Model::ContextualAst] contextual_ast
    # @return [Boolean]
    def nested_list_context?(contextual_ast)
      contextual_ast.context_nodes.count {|node| list?(node)} > 1
    end

    # @param [MetaCommit::Model::ContextualAst] contextual_ast
    # @return [String]
    def parent_list_item_title(contextual_ast)
      parent_element = contextual_ast
                           .context_nodes.reverse # walk from closest node to border
                           .select {|node| list_item?(node)}[1] # li elements
                           .children.first.children.first
      string_content(parent_element)
    end

    # @param [MetaCommit::Extension::MarkdownSupport::Models::Ast] ast
    # @return [Boolean]
    def list?(ast)
      ast.element.type == ELEMENT_TYPE_LISTS
    end

    # @param [MetaCommit::Extension::MarkdownSupport::Models::Ast] ast
    # @return [Boolean]
    def list_item?(ast)
      ast.element.type == ELEMENT_TYPE_LIST_ITEM
    end

    # @param [MetaCommit::Model::ContextualAst] contextual_ast
    # @return [String]
    def closest_header_of_list(contextual_ast)
      sibling_neighbours = context_node_neighbours(contextual_ast)

      closest_header = sibling_neighbours.reverse.find {|neighbour| header?(neighbour)}
      closest_header.children.first.element.string_content unless closest_header.nil?
    end

    # @param [MetaCommit::Model::ContextualAst] contextual_ast
    # @return [String]
    def code_context?(contextual_ast)
      contextual_ast.context_nodes.any? {|node| code?(node)}
    end

    # @param [MetaCommit::Extension::MarkdownSupport::Models::Ast] ast
    # @return [Boolean]
    def code?(ast)
      ast.element.type == ELEMENT_TYPE_CODE
    end

    # @param [MetaCommit::Model::ContextualAst] contextual_ast
    # @return [String]
    def code_first_line(contextual_ast)
      codespan = contextual_ast.context_nodes.reverse.find {|node| code?(node)}
      codespan.element.fence_info
    end

    # @param [MetaCommit::Model::ContextualAst] contextual_ast
    # @return [String]
    def text_context?(contextual_ast)
      contextual_ast.context_nodes.any? {|node| text?(node)}
    end

    # @param [MetaCommit::Extension::MarkdownSupport::Models::Ast] ast
    # @return [Boolean]
    def text?(ast)
      ast.element.type == ELEMENT_TYPE_TEXT
    end

    # @param [MetaCommit::Model::ContextualAst] contextual_ast
    # @return [String]
    def paragraph_context?(contextual_ast)
      contextual_ast.context_nodes.any? {|node| paragraph?(node)}
    end

    # @param [MetaCommit::Extension::MarkdownSupport::Models::Ast] ast
    # @return [Boolean]
    def paragraph?(ast)
      ast.element.type == ELEMENT_TYPE_PARAGRAPH
    end

    # @param [MetaCommit::Extension::MarkdownSupport::Models::Ast] ast
    # @return [Boolean]
    def header?(ast)
      ast.element.type == ELEMENT_TYPE_HEADER
    end

    # @param [MetaCommit::Extension::MarkdownSupport::Models::Ast] ast
    # @return [String]
    def header_content(ast)
      ast.children.first.element.string_content
    end

    # returns ast node that goes before contextual_ast.target_node
    # contextual_ast.context_nodes are filled using depth-first search
    # this method returns value using breadth-first search
    # @param [MetaCommit::Model::ContextualAst] contextual_ast
    # @param [Numeric] depth of level where to search for previous ast
    # @return [MetaCommit::Extension::MarkdownSupport::Model::Ast, nil (?)]
    def context_node_neighbours(contextual_ast, depth=1)
      # TODO depth can be root
      target_node_sibling = contextual_ast.context_nodes[depth]
      node_to_be_searched = contextual_ast.context_nodes[depth - 1]
      previous_children = []
      node_to_be_searched.children.map do |child|
        break if child == target_node_sibling
        previous_children << child
      end
      previous_children
    end

    # @param [MetaCommit::Model::ContextualAst] ast
    # @return [Boolean]
    def contextual_ast_has_target_node(ast)
      !ast.target_node.nil?
    end

    # @param [MetaCommit::Contracts::Ast] ast
    # @param [Integer] line
    # @return [Boolean]
    def starts_on_line?(ast, line)
      ast.first_line === line
    end

    # @param [MetaCommit::Model::ContextualAst] contextual_ast
    # @param [Numeric] line
    # @return [Array<MetaCommit::Model::Node>]
    def context_nodes_on_line(contextual_ast, line)
      contextual_ast.context_nodes.select {|node| starts_on_line?(node, line)}
    end

    # @param [MetaCommit::Extension::MarkdownSupport::Models::Ast] ast
    # @return [Boolean]
    def image?(ast)
      ast.element.type == ELEMENT_TYPE_IMAGE
    end

    # @param [Models::Ast] ast
    # @return [String]
    def string_content(ast)
      case ast.element.type
        when ELEMENT_TYPE_ANCHOR
          ast.children.first.element.string_content
        when ELEMENT_TYPE_LIST_ITEM
          ast.children.first.children.first.element.string_content
        else
          ast.element.string_content
      end
    end
  end
end