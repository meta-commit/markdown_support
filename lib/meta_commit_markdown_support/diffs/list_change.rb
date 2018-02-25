module MetaCommit::Extension::MarkdownSupport::Diffs
  class ListChange < Diff
    # @param [MetaCommit::Contracts::ChangeContext] context
    # @return [Boolean]
    def supports_change(context)
      context.type == TYPE_REPLACE &&
          contextual_ast_has_target_node(context.old_contextual_ast) &&
          contextual_ast_has_target_node(context.new_contextual_ast) &&
          list_context?(context.old_contextual_ast) &&
          list_context?(context.new_contextual_ast)
    end

    # @return [String]
    def string_representation
      # item add to #{list_name()}
      if nested_list_context?(change_context.new_contextual_ast)
        parent_li_title = parent_list_item_title(change_context.new_contextual_ast)
        return "add item to #{parent_li_title.strip} sublist"
      end

      header_content = closest_header_of_list(change_context.new_contextual_ast)
      return "add item to #{header_content} list" unless header_content.nil?
      'add list'
    end
  end
end