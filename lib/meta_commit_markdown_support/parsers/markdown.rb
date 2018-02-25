require 'commonmarker'

module MetaCommit::Extension::MarkdownSupport::Parsers
  class Markdown < MetaCommit::Contracts::Parser
    # @return [Array<String>] supported extensions
    def self.supported_file_extensions
      %w(.markdown .mdown .mkdn .md .mkd .mdwn .mdtxt .mdtext .Rmd)
    end

    # @param [String] source_code
    # @return [Boolean]
    def self.supports_syntax?(source_code)
      begin
        document = CommonMarker.render_doc(source_code)
        !document.nil?
      rescue Encoding::UndefinedConversionError => e
        return false
      end
    end

    # @param [String] source_code
    # @return [MetaCommit::Contracts::Ast]
    def parse(source_code)
      document = CommonMarker.render_doc(source_code)
      MetaCommit::Extension::MarkdownSupport::Models::Ast.new(document)
    end
  end
end