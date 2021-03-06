require 'spec_helper'

describe MetaCommit::Extension::MarkdownSupport::Diffs::CodeDeletion do
  let (:old_file_name) {'file.md'}
  let (:new_file_name) {'file.md'}

  describe '.supports_change' do

    it 'supports deletion of code block' do
      old_source_ast = MetaCommit::Extension::MarkdownSupport::Parsers::Markdown.new.parse(file_fixture(%w(code code_sample)))
      old_contextual_ast = ContextualNodeCreator.new.create_ast_path(old_source_ast, 4)
      new_source_ast = MetaCommit::Extension::MarkdownSupport::Parsers::Markdown.new.parse(file_fixture(%w(code code_sample)))
      new_contextual_ast = ContextualNodeCreator.new.create_ast_path(new_source_ast, 1)

      change_context = MetaCommit::Contracts::ChangeContext.new
      change_context.type = MetaCommit::Extension::MarkdownSupport::Diffs::Diff::TYPE_DELETION
      change_context.commit_id_old = nil
      change_context.commit_id_new = nil
      change_context.old_file_path = old_file_name
      change_context.new_file_path = new_file_name
      change_context.column = 1
      change_context.old_lineno = 4
      change_context.new_lineno = 1
      change_context.old_contextual_ast = old_contextual_ast
      change_context.new_contextual_ast = new_contextual_ast

      expect(subject.supports_change(change_context)).to be_truthy
    end

  end

  describe '#string_representation' do

    it 'spots deletion of code block' do
      old_source_ast = MetaCommit::Extension::MarkdownSupport::Parsers::Markdown.new.parse(file_fixture(%w(code code_sample)))
      old_contextual_ast = ContextualNodeCreator.new.create_ast_path(old_source_ast, 4)
      new_source_ast = MetaCommit::Extension::MarkdownSupport::Parsers::Markdown.new.parse(file_fixture(%w(code code_sample)))
      new_contextual_ast = ContextualNodeCreator.new.create_ast_path(new_source_ast, 1)

      change_context = MetaCommit::Contracts::ChangeContext.new
      change_context.type = MetaCommit::Extension::MarkdownSupport::Diffs::Diff::TYPE_DELETION
      change_context.commit_id_old = nil
      change_context.commit_id_new = nil
      change_context.old_file_path = old_file_name
      change_context.new_file_path = new_file_name
      change_context.column = 1
      change_context.old_lineno = 4
      change_context.new_lineno = 1
      change_context.old_contextual_ast = old_contextual_ast
      change_context.new_contextual_ast = new_contextual_ast

      subject.change_context = change_context

      expect(subject.string_representation).to eq('remove code sample')
    end

    it 'spots deletion in specific language' do
      old_source_ast = MetaCommit::Extension::MarkdownSupport::Parsers::Markdown.new.parse(file_fixture(%w(code ruby_code_sample)))
      old_contextual_ast = ContextualNodeCreator.new.create_ast_path(old_source_ast, 5)
      new_source_ast = MetaCommit::Extension::MarkdownSupport::Parsers::Markdown.new.parse(file_fixture(%w(code ruby_code_sample)))
      new_contextual_ast = ContextualNodeCreator.new.create_ast_path(new_source_ast, 1)

      change_context = MetaCommit::Contracts::ChangeContext.new
      change_context.type = MetaCommit::Extension::MarkdownSupport::Diffs::Diff::TYPE_DELETION
      change_context.commit_id_old = nil
      change_context.commit_id_new = nil
      change_context.old_file_path = old_file_name
      change_context.new_file_path = new_file_name
      change_context.column = 1
      change_context.old_lineno = 5
      change_context.new_lineno = 1
      change_context.old_contextual_ast = old_contextual_ast
      change_context.new_contextual_ast = new_contextual_ast

      subject.change_context = change_context

      expect(subject.string_representation).to eq('remove ruby code sample')
    end

  end
end