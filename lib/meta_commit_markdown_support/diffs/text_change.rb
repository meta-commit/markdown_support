module MetaCommit::Extension::MarkdownSupport::Diffs
  class TextChange < Diff
    # @param [MetaCommit::Contracts::ChangeContext] context
    # @return [Boolean]
    def supports_change(context)
      context.type == TYPE_REPLACE &&
          contextual_ast_has_target_node(context.old_contextual_ast) &&
          contextual_ast_has_target_node(context.new_contextual_ast) &&
          text?(context.old_contextual_ast.target_node) &&
          text?(context.new_contextual_ast.target_node)
    end

    # @return [String]
    def string_representation
      # because target_node is [text]
      # and [parent element] - has -> [paragraph] - has -> [text]
      # and we need to get access to [parent_element] neighbours
      parent_element_depth = change_context.new_contextual_ast.context_nodes.count - 2
      parent_element_neighbours = context_node_neighbours(change_context.new_contextual_ast, parent_element_depth)
      if !parent_element_neighbours.last.nil? && header?(parent_element_neighbours.last)
        header = header_content(parent_element_neighbours.last)
        return "change content of #{header} section"
      end
      "change #{change_context.new_file_path}"
    end
  end
end
