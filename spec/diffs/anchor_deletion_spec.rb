require 'spec_helper'

describe MetaCommit::Extension::MarkdownSupport::Diffs::AnchorDeletion do
  let (:old_file_name) {'file.md'}
  let (:new_file_name) {'file.md'}

  describe '.supports_change' do

    it 'supports anchor deletion' do
      old_source_ast = MetaCommit::Extension::MarkdownSupport::Parsers::Markdown.new.parse(file_fixture(%w(anchor inline_style_link_original)))
      old_contextual_ast = ContextualNodeCreator.new.create_ast_path(old_source_ast, 3)
      new_source_ast = MetaCommit::Extension::MarkdownSupport::Parsers::Markdown.new.parse(file_fixture(%w(anchor inline_style_link_before_adding)))
      new_contextual_ast = ContextualNodeCreator.new.create_ast_path(new_source_ast, 3)

      change_context = MetaCommit::Contracts::ChangeContext.new
      change_context.type = MetaCommit::Extension::MarkdownSupport::Diffs::Diff::TYPE_DELETION
      change_context.commit_id_old = nil
      change_context.commit_id_new = nil
      change_context.old_file_path = old_file_name
      change_context.new_file_path = new_file_name
      change_context.column = 47
      change_context.old_lineno = 3
      change_context.new_lineno = 3
      change_context.old_contextual_ast = old_contextual_ast
      change_context.new_contextual_ast = new_contextual_ast

      expect(subject.supports_change(change_context)).to be_truthy
    end

    it 'supports image deletion' do
      old_source_ast = MetaCommit::Extension::MarkdownSupport::Parsers::Markdown.new.parse("text\ntext\ntext [![Build Status](https://travis-ci.org/usernam3/meta_commit.svg?branch=master)](https://travis-ci.org/usernam3/meta_commit)\ntext")
      old_contextual_ast = ContextualNodeCreator.new.create_ast_path(old_source_ast, 3)
      new_source_ast = MetaCommit::Extension::MarkdownSupport::Parsers::Markdown.new.parse("text\ntext\ntext \ntext")
      new_contextual_ast = ContextualNodeCreator.new.create_ast_path(new_source_ast, 3)

      change_context = MetaCommit::Contracts::ChangeContext.new
      change_context.type = MetaCommit::Extension::MarkdownSupport::Diffs::Diff::TYPE_DELETION
      change_context.commit_id_old = nil
      change_context.commit_id_new = nil
      change_context.old_file_path = old_file_name
      change_context.new_file_path = new_file_name
      change_context.old_lineno = nil
      change_context.new_lineno = 3
      change_context.column = 4
      change_context.old_contextual_ast = old_contextual_ast
      change_context.new_contextual_ast = new_contextual_ast

      expect(subject.supports_change(change_context)).to be_truthy
    end

  end

  describe '#string_representation' do

    it 'spots anchor delete' do
      old_source_ast = MetaCommit::Extension::MarkdownSupport::Parsers::Markdown.new.parse(file_fixture(%w(anchor inline_style_link_original)))
      old_contextual_ast = ContextualNodeCreator.new.create_ast_path(old_source_ast, 3)
      new_source_ast = MetaCommit::Extension::MarkdownSupport::Parsers::Markdown.new.parse(file_fixture(%w(anchor inline_style_link_before_adding)))
      new_contextual_ast = ContextualNodeCreator.new.create_ast_path(new_source_ast, 3)

      change_context = MetaCommit::Contracts::ChangeContext.new
      change_context.type = MetaCommit::Extension::MarkdownSupport::Diffs::Diff::TYPE_DELETION
      change_context.commit_id_old = nil
      change_context.commit_id_new = nil
      change_context.old_file_path = old_file_name
      change_context.new_file_path = new_file_name
      change_context.column = 47
      change_context.old_lineno = 3
      change_context.new_lineno = 3
      change_context.old_contextual_ast = old_contextual_ast
      change_context.new_contextual_ast = new_contextual_ast

      subject.change_context = change_context

      expect(subject.string_representation).to eq('delete link text itself link')
    end

    it 'spots when image anchor deleted' do
      old_source_ast = MetaCommit::Extension::MarkdownSupport::Parsers::Markdown.new.parse("text\ntext\ntext [![Build Status](https://travis-ci.org/usernam3/meta_commit.svg?branch=master)](https://travis-ci.org/usernam3/meta_commit)\ntext")
      old_contextual_ast = ContextualNodeCreator.new.create_ast_path(old_source_ast, 3)
      new_source_ast = MetaCommit::Extension::MarkdownSupport::Parsers::Markdown.new.parse("text\ntext\ntext \ntext")
      new_contextual_ast = ContextualNodeCreator.new.create_ast_path(new_source_ast, 3)

      change_context = MetaCommit::Contracts::ChangeContext.new
      change_context.type = MetaCommit::Extension::MarkdownSupport::Diffs::Diff::TYPE_DELETION
      change_context.commit_id_old = nil
      change_context.commit_id_new = nil
      change_context.old_file_path = old_file_name
      change_context.new_file_path = new_file_name
      change_context.old_lineno = nil
      change_context.new_lineno = 3
      change_context.column = 4
      change_context.old_contextual_ast = old_contextual_ast
      change_context.new_contextual_ast = new_contextual_ast

      subject.change_context = change_context

      expect(subject.string_representation).to eq('delete Build Status')
    end

  end
end