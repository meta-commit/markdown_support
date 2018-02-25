class ContextualNodeCreator

  # @param [MetaCommit::Contracts::Ast] source_ast
  # @return [MetaCommit::Contracts::ContextualAst]
  def create_ast_path_with_whole_file_change(source_ast)
    contextual_ast = MetaCommit::Contracts::ContextualAst.new
    contextual_ast.parser_class = source_ast.parser_class
    contextual_ast.target_node = source_ast
    contextual_ast.context_nodes = []
    contextual_ast
  end

  # @param [MetaCommit::Contracts::Ast] source_ast
  # @param [Integer] line_number
  # @return [MetaCommit::Contracts::ContextualAst]
  def create_ast_path(source_ast, line_number)
    visited_nodes = []
    contextual_ast = MetaCommit::Contracts::ContextualAst.new
    contextual_ast.parser_class = source_ast.parser_class
    contextual_ast.target_node = collect_path_to_ast_at_line(source_ast, line_number, visited_nodes)
    contextual_ast.context_nodes = visited_nodes
    contextual_ast
  end

  # @param [MetaCommit::Contracts::Ast] ast
  # @param [Integer] lineno
  # @param [Array<MetaCommit::Contracts::Ast>] accumulator
  # @return [MetaCommit::Contracts::Ast]
  def collect_path_to_ast_at_line(ast, lineno, accumulator)
    return nil if ast.nil? || (lines?(ast) && !covers_line?(ast, lineno))

    closest_ast = ast
    accumulator.push(closest_ast)
    ast.children.each do |child|
      found_ast = collect_path_to_ast_at_line(child, lineno, accumulator)
      closest_ast = found_ast unless found_ast.nil?
    end
    closest_ast
  end

  protected :collect_path_to_ast_at_line


  # @param [MetaCommit::Contracts::Ast] ast
  # @return [Boolean]
  def lines?(ast)
    !(ast.first_line.nil? && ast.last_line.nil?)
  end

  protected :lines?


  # @param [MetaCommit::Contracts::Ast] ast
  # @param [Integer] line
  # @return [Boolean]
  def covers_line?(ast, line)
    (ast.first_line <= line) && (ast.last_line >= line)
  end

  protected :covers_line?
end