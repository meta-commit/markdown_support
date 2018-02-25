module MetaCommit::Extension::MarkdownSupport::Diffs
  class TextDeletion < Diff
    # @param [MetaCommit::Contracts::ChangeContext] context
    # @return [Boolean]
    def supports_change(context)
      context.type == TYPE_DELETION &&
          contextual_ast_has_target_node(context.old_contextual_ast) &&
          text?(context.old_contextual_ast.target_node)
    end

    # @return [String]
    def string_representation
      # because target_node is [text]
      # and [parent element] - has -> [paragraph] - has -> [text]
      # and wee need to get access to [parent_element] neighbours
      parent_element_depth = change_context.old_contextual_ast.context_nodes.count - 2
      parent_element_neighbours = context_node_neighbours(change_context.old_contextual_ast, parent_element_depth)
      if !(parent_element_neighbours.empty?) && header?(parent_element_neighbours.last)
        header = header_content(parent_element_neighbours.last)
        return "remove paragraph from '#{header}' section"
      end
      "remove paragraph from #{change_context.new_file_path}"
    end
  end
end
