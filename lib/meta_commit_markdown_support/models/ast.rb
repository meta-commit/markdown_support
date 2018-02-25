module MetaCommit::Extension::MarkdownSupport::Models
  # Adapter which implements MetaCommit::Contracts::Ast contract and wraps CommonMarker::Node
  # @attr [CommonMarker::Node] element
  class Ast < MetaCommit::Contracts::Ast
    attr_reader :element

    # @param [CommonMarker::Node] element
    def initialize(element)
      @element = element
    end

    # @return [Array<MetaCommit::Contracts::Ast>] children ast
    def children
      element.each.map do |child|
        Ast.new(child)
      end
    end

    # @return [Integer, nil] line number where ast starts
    def first_line
      element.sourcepos[:start_line]
    end

    # @return [Integer, nil] line number where ast ends
    def last_line
      element.sourcepos[:end_line]
    end

    # @return [Integer, nil] column number where ast starts
    def first_column
      return nil if element.sourcepos[:start_column].nil?
      element.sourcepos[:start_column] - 1
    end

    # @return [Integer, nil] column number where ast ends
    def last_column
      return nil if element.sourcepos[:end_column].nil?
      element.sourcepos[:end_column] - 1
    end

    # @param [MetaCommit::Extension::MarkdownSupport::Models::Ast] right_ast
    # @return [Boolean]
    def ==(right_ast)
      element == right_ast.element
    end
  end
end