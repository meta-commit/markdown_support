require 'spec_helper'

describe MetaCommit::Extension::MarkdownSupport::Diffs::TextAddition do
  let (:old_file_name) {'file.md'}
  let (:new_file_name) {'file.md'}

  describe '.supports_change' do

    it 'supports text addition' do
      old_source_ast = MetaCommit::Extension::MarkdownSupport::Parsers::Markdown.new.parse(file_fixture(%w(text markdown_entities)))
      old_contextual_ast = ContextualNodeCreator.new.create_ast_path(old_source_ast, 11)
      new_source_ast = MetaCommit::Extension::MarkdownSupport::Parsers::Markdown.new.parse(file_fixture(%w(text markdown_entities_with_added_paragraph)))
      new_contextual_ast = ContextualNodeCreator.new.create_ast_path(new_source_ast, 11)

      change_context = MetaCommit::Contracts::ChangeContext.new
      change_context.type = MetaCommit::Extension::MarkdownSupport::Diffs::Diff::TYPE_ADDITION
      change_context.commit_id_old = nil
      change_context.commit_id_new = nil
      change_context.old_file_path = old_file_name
      change_context.new_file_path = new_file_name
      change_context.column = 0
      change_context.old_lineno = 11
      change_context.new_lineno = 11
      change_context.old_contextual_ast = old_contextual_ast
      change_context.new_contextual_ast = new_contextual_ast

      expect(subject.supports_change(change_context)).to be_truthy
    end

  end

  describe '#string_representation' do

    it 'takes title from header' do
      old_source_ast = MetaCommit::Extension::MarkdownSupport::Parsers::Markdown.new.parse(file_fixture(%w(text markdown_entities)))
      old_contextual_ast = ContextualNodeCreator.new.create_ast_path(old_source_ast, 11)
      new_source_ast = MetaCommit::Extension::MarkdownSupport::Parsers::Markdown.new.parse(file_fixture(%w(text markdown_entities_with_added_paragraph)))
      new_contextual_ast = ContextualNodeCreator.new.create_ast_path(new_source_ast, 11)

      change_context = MetaCommit::Contracts::ChangeContext.new
      change_context.type = MetaCommit::Extension::MarkdownSupport::Diffs::Diff::TYPE_ADDITION
      change_context.commit_id_old = nil
      change_context.commit_id_new = nil
      change_context.old_file_path = old_file_name
      change_context.new_file_path = new_file_name
      change_context.column = 0
      change_context.old_lineno = 11
      change_context.new_lineno = 11
      change_context.old_contextual_ast = old_contextual_ast
      change_context.new_contextual_ast = new_contextual_ast

      subject.change_context = change_context

      expect(subject.string_representation).to eq("add text to 'The MIT License' section")
    end

    it 'takes title from file name' do
      old_source_ast = MetaCommit::Extension::MarkdownSupport::Parsers::Markdown.new.parse(file_fixture(%w(text paragraph)))
      old_contextual_ast = ContextualNodeCreator.new.create_ast_path(old_source_ast, 3)
      new_source_ast = MetaCommit::Extension::MarkdownSupport::Parsers::Markdown.new.parse(file_fixture(%w(text 2_paragraphs)))
      new_contextual_ast = ContextualNodeCreator.new.create_ast_path(new_source_ast, 5)

      change_context = MetaCommit::Contracts::ChangeContext.new
      change_context.type = MetaCommit::Extension::MarkdownSupport::Diffs::Diff::TYPE_ADDITION
      change_context.commit_id_old = nil
      change_context.commit_id_new = nil
      change_context.column = 0
      change_context.old_file_path = old_file_name
      change_context.new_file_path = new_file_name
      change_context.old_lineno = 3
      change_context.new_lineno = 3
      change_context.old_contextual_ast = old_contextual_ast
      change_context.new_contextual_ast = new_contextual_ast

      subject.change_context = change_context

      expect(subject.string_representation).to eq('add text to file.md')
    end

  end
end