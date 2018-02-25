require 'spec_helper'

describe MetaCommit::Extension::MarkdownSupport::Diffs::CodeChange do
  let (:old_file_name) {'file.md'}
  let (:new_file_name) {'file.md'}

  describe '#string_representation' do

    it 'spots change of code block' do
      old_source_ast = MetaCommit::Extension::MarkdownSupport::Parsers::Markdown.new.parse(file_fixture(%w(code ruby_code_sample)))
      old_contextual_ast = ContextualNodeCreator.new.create_ast_path(old_source_ast, 5)
      new_source_ast = MetaCommit::Extension::MarkdownSupport::Parsers::Markdown.new.parse(file_fixture(%w(code code_sample)))
      new_contextual_ast = ContextualNodeCreator.new.create_ast_path(new_source_ast, 5)

      change_context = MetaCommit::Contracts::ChangeContext.new
      change_context.type = MetaCommit::Extension::MarkdownSupport::Diffs::Diff::TYPE_REPLACE
      change_context.commit_id_old = nil
      change_context.commit_id_new = nil
      change_context.old_file_path = old_file_name
      change_context.new_file_path = new_file_name
      change_context.old_lineno = 0
      change_context.old_lineno = 4
      change_context.new_lineno = 4
      change_context.old_contextual_ast = old_contextual_ast
      change_context.new_contextual_ast = new_contextual_ast

      subject.change_context = change_context

      expect(subject.string_representation).to eq('change code sample')
    end

    it 'spots change in specific language' do
      old_source_ast = MetaCommit::Extension::MarkdownSupport::Parsers::Markdown.new.parse(file_fixture(%w(code code_sample)))
      old_contextual_ast = ContextualNodeCreator.new.create_ast_path(old_source_ast, 6)
      new_source_ast = MetaCommit::Extension::MarkdownSupport::Parsers::Markdown.new.parse(file_fixture(%w(code ruby_code_sample)))
      new_contextual_ast = ContextualNodeCreator.new.create_ast_path(new_source_ast, 6)

      change_context = MetaCommit::Contracts::ChangeContext.new
      change_context.type = MetaCommit::Extension::MarkdownSupport::Diffs::Diff::TYPE_REPLACE
      change_context.commit_id_old = nil
      change_context.commit_id_new = nil
      change_context.old_file_path = old_file_name
      change_context.new_file_path = new_file_name
      change_context.old_lineno = 0
      change_context.old_lineno = 4
      change_context.new_lineno = 4
      change_context.old_contextual_ast = old_contextual_ast
      change_context.new_contextual_ast = new_contextual_ast

      subject.change_context = change_context

      expect(subject.string_representation).to eq('change ruby code sample')
    end

  end
end