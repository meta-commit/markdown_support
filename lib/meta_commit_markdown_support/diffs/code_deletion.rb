module MetaCommit::Extension::MarkdownSupport::Diffs
  class CodeDeletion < Diff
    # @param [MetaCommit::Contracts::ChangeContext] context
    # @return [Boolean]
    def supports_change(context)
      context.type == TYPE_DELETION &&
          contextual_ast_has_target_node(context.old_contextual_ast) &&
          (code_context?(context.old_contextual_ast) || code?(context.old_contextual_ast.target_node))
    end

    # @return [String]
    def string_representation
      first_line = code_first_line(change_context.old_contextual_ast)
      return "remove #{first_line} code sample" unless first_line.empty?
      'remove code sample'
    end
  end
end