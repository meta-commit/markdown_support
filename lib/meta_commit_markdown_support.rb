require "meta_commit_contracts"

module MetaCommit
  module Extensions
    module MarkdownSupport
    end
  end
end

require "meta_commit_markdown_support/version"
require "meta_commit_markdown_support/helpers/contextual_ast_accessor"

require "meta_commit_markdown_support/models/ast"

require "meta_commit_markdown_support/parsers/markdown"

require "meta_commit_markdown_support/locator"

require "meta_commit_markdown_support/diffs/diff"

require "meta_commit_markdown_support/diffs/anchor_addition"
require "meta_commit_markdown_support/diffs/anchor_rename"
require "meta_commit_markdown_support/diffs/anchor_deletion"

require "meta_commit_markdown_support/diffs/list_addition"
require "meta_commit_markdown_support/diffs/list_change"
require "meta_commit_markdown_support/diffs/list_deletion"

require "meta_commit_markdown_support/diffs/code_addition"
require "meta_commit_markdown_support/diffs/code_change"
require "meta_commit_markdown_support/diffs/code_deletion"

require "meta_commit_markdown_support/diffs/text_addition"
require "meta_commit_markdown_support/diffs/text_change"
require "meta_commit_markdown_support/diffs/text_deletion"
