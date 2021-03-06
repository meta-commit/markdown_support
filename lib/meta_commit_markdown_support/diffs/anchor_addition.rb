module MetaCommit::Extension::MarkdownSupport::Diffs
  class AnchorAddition < Diff
    # @param [MetaCommit::Contracts::ChangeContext] context
    # @return [Boolean]
    def supports_change(context)
      context.type == TYPE_ADDITION &&
          contextual_ast_has_target_node(context.new_contextual_ast) &&
          anchor_context?(context.new_contextual_ast)
    end

    # @return [String]
    def string_representation
      parent_anchor = change_context.new_contextual_ast
                          .context_nodes
                          .find {|node| anchor?(node)}

      if !parent_anchor.children.first.nil? && text?(parent_anchor.children.first)
        new_anchor_title = parent_anchor.element.first_child.string_content
        parent_anchor.element.first_child.string_content
        return "add #{new_anchor_title} link"
      end

      if !parent_anchor.children.first.nil? && image?(parent_anchor.children.first)
        new_anchor_title = parent_anchor.element.first_child.first_child.string_content
        parent_anchor.element.first_child.first_child.string_content
        return "add #{new_anchor_title}"
      end

      anchor_target = anchor_target(change_context.new_contextual_ast)
      "delete #{anchor_target} link"
    end
  end
end