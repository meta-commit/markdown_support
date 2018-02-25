module MetaCommit::Extension::MarkdownSupport::Diffs
  class CodeAddition < Diff
    # @param [MetaCommit::Contracts::ChangeContext] context
    # @return [Boolean]
    def supports_change(context)
      context.type == TYPE_ADDITION &&
          contextual_ast_has_target_node(context.new_contextual_ast) &&
          (code_context?(context.new_contextual_ast) || code?(context.new_contextual_ast.target_node))
    end

    # @return [String]
    def string_representation
      first_line = code_first_line(change_context.new_contextual_ast)
      return "add #{first_line} code sample" unless first_line.empty?
      'add code sample'
    end
  end
end