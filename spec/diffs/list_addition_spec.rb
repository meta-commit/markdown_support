require 'spec_helper'

describe MetaCommit::Extension::MarkdownSupport::Diffs::ListAddition do
  let (:old_file_name) {'file.md'}
  let (:new_file_name) {'file.md'}

  describe '.supports_change' do

    it 'supports list addition' do
      old_source_ast = MetaCommit::Extension::MarkdownSupport::Parsers::Markdown.new.parse(file_fixture(%w(list sample)))
      old_contextual_ast = ContextualNodeCreator.new.create_ast_path(old_source_ast, 7)
      new_source_ast = MetaCommit::Extension::MarkdownSupport::Parsers::Markdown.new.parse(file_fixture(%w(list sample_with_list)))
      new_contextual_ast = ContextualNodeCreator.new.create_ast_path(new_source_ast, 8)

      change_context = MetaCommit::Contracts::ChangeContext.new
      change_context.type = MetaCommit::Extension::MarkdownSupport::Diffs::Diff::TYPE_ADDITION
      change_context.commit_id_old = nil
      change_context.commit_id_new = nil
      change_context.old_file_path = old_file_name
      change_context.new_file_path = new_file_name
      change_context.column = 1
      change_context.old_lineno = 7
      change_context.new_lineno = 8
      change_context.old_contextual_ast = old_contextual_ast
      change_context.new_contextual_ast = new_contextual_ast

      expect(subject.supports_change(change_context)).to be_truthy
    end

    it 'supports nested list addition' do
      old_source_ast = MetaCommit::Extension::MarkdownSupport::Parsers::Markdown.new.parse(file_fixture(%w(list sample_with_list)))
      old_contextual_ast = ContextualNodeCreator.new.create_ast_path(old_source_ast, 9)
      new_source_ast = MetaCommit::Extension::MarkdownSupport::Parsers::Markdown.new.parse(file_fixture(%w(list sample_with_nested_list)))
      new_contextual_ast = ContextualNodeCreator.new.create_ast_path(new_source_ast, 9)

      change_context = MetaCommit::Contracts::ChangeContext.new
      change_context.type = MetaCommit::Extension::MarkdownSupport::Diffs::Diff::TYPE_ADDITION
      change_context.commit_id_old = nil
      change_context.commit_id_new = nil
      change_context.old_file_path = old_file_name
      change_context.new_file_path = new_file_name
      change_context.column = 0
      change_context.old_lineno = 9
      change_context.new_lineno = 9
      change_context.old_contextual_ast = old_contextual_ast
      change_context.new_contextual_ast = new_contextual_ast

      expect(subject.supports_change(change_context)).to be_truthy
    end

  end

  describe '#string_representation' do

    it 'spots addition of list' do
      old_source_ast = MetaCommit::Extension::MarkdownSupport::Parsers::Markdown.new.parse(file_fixture(%w(list sample)))
      old_contextual_ast = ContextualNodeCreator.new.create_ast_path(old_source_ast, 7)
      new_source_ast = MetaCommit::Extension::MarkdownSupport::Parsers::Markdown.new.parse(file_fixture(%w(list sample_with_list)))
      new_contextual_ast = ContextualNodeCreator.new.create_ast_path(new_source_ast, 8)

      change_context = MetaCommit::Contracts::ChangeContext.new
      change_context.type = MetaCommit::Extension::MarkdownSupport::Diffs::Diff::TYPE_ADDITION
      change_context.commit_id_old = nil
      change_context.commit_id_new = nil
      change_context.old_file_path = old_file_name
      change_context.new_file_path = new_file_name
      change_context.column = 1
      change_context.old_lineno = 7
      change_context.new_lineno = 8
      change_context.old_contextual_ast = old_contextual_ast
      change_context.new_contextual_ast = new_contextual_ast

      subject.change_context = change_context

      expect(subject.string_representation).to eq('add list')
    end

    it 'spots addition of list and takes title from closest header' do
      old_source_ast = MetaCommit::Extension::MarkdownSupport::Parsers::Markdown.new.parse(file_fixture(%w(list sample)))
      old_contextual_ast = ContextualNodeCreator.new.create_ast_path(old_source_ast, 7)
      new_source_ast = MetaCommit::Extension::MarkdownSupport::Parsers::Markdown.new.parse(file_fixture(%w(list sample_with_list_and_header)))
      new_contextual_ast = ContextualNodeCreator.new.create_ast_path(new_source_ast, 8)

      change_context = MetaCommit::Contracts::ChangeContext.new
      change_context.type = MetaCommit::Extension::MarkdownSupport::Diffs::Diff::TYPE_ADDITION
      change_context.commit_id_old = nil
      change_context.commit_id_new = nil
      change_context.old_file_path = old_file_name
      change_context.new_file_path = new_file_name
      change_context.column = 0
      change_context.old_lineno = 7
      change_context.new_lineno = 8
      change_context.old_contextual_ast = old_contextual_ast
      change_context.new_contextual_ast = new_contextual_ast

      subject.change_context = change_context

      expect(subject.string_representation).to eq('add list to Section with header 2')
    end

    it 'spots addition of nested list and takes title parent element' do
      old_source_ast = MetaCommit::Extension::MarkdownSupport::Parsers::Markdown.new.parse(file_fixture(%w(list sample_with_list)))
      old_contextual_ast = ContextualNodeCreator.new.create_ast_path(old_source_ast, 9)
      new_source_ast = MetaCommit::Extension::MarkdownSupport::Parsers::Markdown.new.parse(file_fixture(%w(list sample_with_nested_list)))
      new_contextual_ast = ContextualNodeCreator.new.create_ast_path(new_source_ast, 9)

      change_context = MetaCommit::Contracts::ChangeContext.new
      change_context.type = MetaCommit::Extension::MarkdownSupport::Diffs::Diff::TYPE_ADDITION
      change_context.commit_id_old = nil
      change_context.commit_id_new = nil
      change_context.old_file_path = old_file_name
      change_context.new_file_path = new_file_name
      change_context.column = 0
      change_context.old_lineno = 9
      change_context.new_lineno = 9
      change_context.old_contextual_ast = old_contextual_ast
      change_context.new_contextual_ast = new_contextual_ast

      subject.change_context = change_context

      expect(subject.string_representation).to eq('add sublist to The above copyright notice shall be included in')
    end
  end
end