module MetaCommit::Extension::MarkdownSupport::Diffs
  class ListDeletion < Diff
    # @param [MetaCommit::Contracts::ChangeContext] context
    # @return [Boolean]
    def supports_change(context)
      context.type == TYPE_DELETION &&
          contextual_ast_has_target_node(context.old_contextual_ast) &&
          list_context?(context.old_contextual_ast)
    end

    # @return [String]
    def string_representation
      if nested_list_context?(change_context.old_contextual_ast)
        parent_li_title = parent_list_item_title(change_context.old_contextual_ast)
        return "remove #{parent_li_title.strip} sublist"
      end

      header_content = closest_header_of_list(change_context.old_contextual_ast)
      return "remove #{header_content} list" unless header_content.nil?
      'remove list'
    end
  end
end