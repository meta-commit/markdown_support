module MetaCommit::Extension::MarkdownSupport::Diffs
  class TextAddition < Diff
    # @param [MetaCommit::Contracts::ChangeContext] context
    # @return [Boolean]
    def supports_change(context)
      context.type == TYPE_ADDITION &&
          contextual_ast_has_target_node(context.new_contextual_ast) &&
          text?(context.new_contextual_ast.target_node)
    end

    # @return [String]
    def string_representation
      # because target_node is [text]
      # and [parent element] - has -> [paragraph] - has -> [text]
      # and wee need to get access to [parent_element] neighbours
      parent_element_depth = change_context.new_contextual_ast.context_nodes.count - 2
      parent_element_neighbours = context_node_neighbours(change_context.new_contextual_ast, parent_element_depth)
      if !(parent_element_neighbours.empty?) && header?(parent_element_neighbours.last)
        header = header_content(parent_element_neighbours.last)
        return "add text to '#{header}' section"
      end
      "add text to #{change_context.new_file_path}"
    end
  end
end
