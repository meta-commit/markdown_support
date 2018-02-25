module MetaCommit::Extension::MarkdownSupport::Diffs
  class CodeChange < Diff
    # @param [MetaCommit::Contracts::ChangeContext] context
    # @return [Boolean]
    def supports_change(context)
      context.type == TYPE_REPLACE &&
          contextual_ast_has_target_node(context.new_contextual_ast) && contextual_ast_has_target_node(context.old_contextual_ast) &&
          (code_context?(context.old_contextual_ast) || code?(context.old_contextual_ast.target_node)) &&
          (code_context?(context.new_contextual_ast) || code?(context.new_contextual_ast.target_node))
    end

    # @return [String]
    def string_representation
      first_line = code_first_line(change_context.new_contextual_ast)
      return "change #{first_line} code sample" unless first_line.empty?
      'change code sample'
    end
  end
end