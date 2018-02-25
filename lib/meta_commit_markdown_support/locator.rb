module MetaCommit::Extension::MarkdownSupport
  # Package interface
  class Locator < MetaCommit::Contracts::Locator
    # @return [Array] parser classes that package provides
    def parsers
      [
          MetaCommit::Extension::MarkdownSupport::Parsers::Markdown
      ]
    end

    # @return [Array] diff classes that package provides
    def diffs
      [
          MetaCommit::Extension::MarkdownSupport::Diffs::AnchorAddition,
          MetaCommit::Extension::MarkdownSupport::Diffs::AnchorDeletion,
          MetaCommit::Extension::MarkdownSupport::Diffs::AnchorRename,
          MetaCommit::Extension::MarkdownSupport::Diffs::CodeAddition,
          MetaCommit::Extension::MarkdownSupport::Diffs::CodeChange,
          MetaCommit::Extension::MarkdownSupport::Diffs::CodeDeletion,
          MetaCommit::Extension::MarkdownSupport::Diffs::ListAddition,
          MetaCommit::Extension::MarkdownSupport::Diffs::ListChange,
          MetaCommit::Extension::MarkdownSupport::Diffs::ListDeletion,
          MetaCommit::Extension::MarkdownSupport::Diffs::TextAddition,
          MetaCommit::Extension::MarkdownSupport::Diffs::TextChange,
          MetaCommit::Extension::MarkdownSupport::Diffs::TextDeletion
      ]
    end
  end
end