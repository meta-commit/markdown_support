require 'spec_helper'

describe MetaCommit::Extension::MarkdownSupport::Diffs::AnchorAddition do
  let (:old_file_name) {'file.md'}
  let (:new_file_name) {'file.md'}

  describe '.supports_change' do

    it 'supports anchor addition' do
      old_source_ast = MetaCommit::Extension::MarkdownSupport::Parsers::Markdown.new.parse("text\ntext\ntext text\ntext")
      old_contextual_ast = ContextualNodeCreator.new.create_ast_path(old_source_ast, 3)
      new_source_ast = MetaCommit::Extension::MarkdownSupport::Parsers::Markdown.new.parse("text\ntext\ntext [displayed name](http://link.target) text\ntext")
      new_contextual_ast = ContextualNodeCreator.new.create_ast_path(new_source_ast, 3)

      change_context = MetaCommit::Contracts::ChangeContext.new
      change_context.type = MetaCommit::Extension::MarkdownSupport::Diffs::Diff::TYPE_ADDITION
      change_context.commit_id_old = nil
      change_context.commit_id_new = nil
      change_context.old_file_path = old_file_name
      change_context.new_file_path = new_file_name
      change_context.old_lineno = nil
      change_context.new_lineno = 3
      change_context.column = 5
      change_context.old_contextual_ast = old_contextual_ast
      change_context.new_contextual_ast = new_contextual_ast

      expect(subject.supports_change(change_context)).to be_truthy
    end

    it 'supports image addition' do
      old_source_ast = MetaCommit::Extension::MarkdownSupport::Parsers::Markdown.new.parse("text\ntext\ntext \ntext")
      old_contextual_ast = ContextualNodeCreator.new.create_ast_path(old_source_ast, 3)
      new_source_ast = MetaCommit::Extension::MarkdownSupport::Parsers::Markdown.new.parse("text\ntext\ntext [![Build Status](https://travis-ci.org/usernam3/meta_commit.svg?branch=master)](https://travis-ci.org/usernam3/meta_commit)\ntext")
      new_contextual_ast = ContextualNodeCreator.new.create_ast_path(new_source_ast, 3)

      change_context = MetaCommit::Contracts::ChangeContext.new
      change_context.type = MetaCommit::Extension::MarkdownSupport::Diffs::Diff::TYPE_ADDITION
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

    it 'spots that inline link added' do
      old_source_ast = MetaCommit::Extension::MarkdownSupport::Parsers::Markdown.new.parse("text\ntext\ntext text\ntext")
      old_contextual_ast = ContextualNodeCreator.new.create_ast_path(old_source_ast, 3)
      new_source_ast = MetaCommit::Extension::MarkdownSupport::Parsers::Markdown.new.parse("text\ntext\ntext [displayed name](http://link.target) text\ntext")
      new_contextual_ast = ContextualNodeCreator.new.create_ast_path(new_source_ast, 3)

      change_context = MetaCommit::Contracts::ChangeContext.new
      change_context.type = MetaCommit::Extension::MarkdownSupport::Diffs::Diff::TYPE_ADDITION
      change_context.commit_id_old = nil
      change_context.commit_id_new = nil
      change_context.old_file_path = old_file_name
      change_context.new_file_path = new_file_name
      change_context.old_lineno = nil
      change_context.new_lineno = 3
      change_context.column = 5
      change_context.old_contextual_ast = old_contextual_ast
      change_context.new_contextual_ast = new_contextual_ast

      subject.change_context = change_context

      expect(subject.string_representation).to eq('add displayed name link')
    end

    it 'spots that inline link added with backspace' do
      old_source_ast = MetaCommit::Extension::MarkdownSupport::Parsers::Markdown.new.parse("text\ntext\ntext \ntext")
      old_contextual_ast = ContextualNodeCreator.new.create_ast_path(old_source_ast, 3)
      new_source_ast = MetaCommit::Extension::MarkdownSupport::Parsers::Markdown.new.parse("text\ntext\ntext [displayed name](http://link.target) text\ntext")
      new_contextual_ast = ContextualNodeCreator.new.create_ast_path(new_source_ast, 3)

      change_context = MetaCommit::Contracts::ChangeContext.new
      change_context.type = MetaCommit::Extension::MarkdownSupport::Diffs::Diff::TYPE_ADDITION
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

      expect(subject.string_representation).to eq('add displayed name link')
    end

    it 'spots when image link added' do
      old_source_ast = MetaCommit::Extension::MarkdownSupport::Parsers::Markdown.new.parse("text\ntext\ntext \ntext")
      old_contextual_ast = ContextualNodeCreator.new.create_ast_path(old_source_ast, 3)
      new_source_ast = MetaCommit::Extension::MarkdownSupport::Parsers::Markdown.new.parse("text\ntext\ntext [![Build Status](https://travis-ci.org/usernam3/meta_commit.svg?branch=master)](https://travis-ci.org/usernam3/meta_commit)\ntext")
      new_contextual_ast = ContextualNodeCreator.new.create_ast_path(new_source_ast, 3)

      change_context = MetaCommit::Contracts::ChangeContext.new
      change_context.type = MetaCommit::Extension::MarkdownSupport::Diffs::Diff::TYPE_ADDITION
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

      expect(subject.string_representation).to eq('add Build Status')
    end

  end
end