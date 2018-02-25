module MetaCommit::Extension::MarkdownSupport::Diffs
  class AnchorRename < Diff
    # @param [MetaCommit::Contracts::ChangeContext] context
    # @return [Boolean]
    def supports_change(context)
      context.type == TYPE_REPLACE &&
          contextual_ast_has_target_node(context.old_contextual_ast) && contextual_ast_has_target_node(context.new_contextual_ast) &&
          anchor_context?(context.old_contextual_ast) && anchor_context?(context.new_contextual_ast)
    end

    # @return [String]
    def string_representation
      old_links = elements_of_type_on_line(change_context.old_contextual_ast, ELEMENT_TYPE_ANCHOR, change_context.old_lineno)
      new_links = elements_of_type_on_line(change_context.new_contextual_ast, ELEMENT_TYPE_ANCHOR, change_context.new_lineno)

      closest_old_link = element_closest_to(old_links, change_context.column)
      closest_new_link = element_closest_to(new_links, change_context.column)

      if !closest_new_link.nil? && !closest_new_link.children.first.nil? && text?(closest_new_link.children.first)
        new_anchor_title = closest_new_link.element.first_child.string_content
        closest_new_link.element.first_child.string_content
        return "change #{new_anchor_title} link"
      end

      if !closest_new_link.nil? && !closest_new_link.children.first.nil? && image?(closest_new_link.children.first)
        new_anchor_title = closest_new_link.element.first_child.first_child.string_content
        closest_new_link.element.first_child.first_child.string_content
        return "change #{new_anchor_title}"
      end

      anchor_target = anchor_target(change_context.new_contextual_ast)
      "change #{anchor_target} link"
    end
  end
end