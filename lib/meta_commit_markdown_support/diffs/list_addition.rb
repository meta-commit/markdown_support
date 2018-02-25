module MetaCommit::Extension::MarkdownSupport::Diffs
  class ListAddition < Diff
    # @param [MetaCommit::Contracts::ChangeContext] context
    # @return [Boolean]
    def supports_change(context)
      context.type == TYPE_ADDITION &&
          contextual_ast_has_target_node(context.old_contextual_ast) && contextual_ast_has_target_node(context.new_contextual_ast) &&
          list_context?(context.new_contextual_ast)
    end

    # @return [String]
    def string_representation
      if nested_list_context?(change_context.new_contextual_ast)
        parent_li_title = parent_list_item_title(change_context.new_contextual_ast)
        return "add sublist to #{parent_li_title.strip}"
      end

      header_content = closest_header_of_list(change_context.new_contextual_ast)
      return "add list to #{header_content}" unless header_content.nil?
      'add list'
    end
  end
end