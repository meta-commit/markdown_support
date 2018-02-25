require 'spec_helper'

describe MetaCommit::Extension::MarkdownSupport::Diffs::AnchorRename do
  let (:old_file_name) {'file.md'}
  let (:new_file_name) {'file.md'}

  describe '.supports_change' do

    it 'supports anchor change' do
      old_source_ast = MetaCommit::Extension::MarkdownSupport::Parsers::Markdown.new.parse("line\ntext [domain title](http://domain.test) [second domain title](http://second_domain.test) text\nline")
      old_contextual_ast = ContextualNodeCreator.new.create_ast_path(old_source_ast, 2)
      new_source_ast = MetaCommit::Extension::MarkdownSupport::Parsers::Markdown.new.parse("line\ntext [domain title](http://other_domain.test) [other domain title](http://other_domain.test) text\nline")
      new_contextual_ast = ContextualNodeCreator.new.create_ast_path(new_source_ast, 2)

      change_context = MetaCommit::Contracts::ChangeContext.new
      change_context.type = MetaCommit::Extension::MarkdownSupport::Diffs::Diff::TYPE_REPLACE
      change_context.commit_id_old = nil
      change_context.commit_id_new = nil
      change_context.old_file_path = old_file_name
      change_context.new_file_path = new_file_name
      change_context.column = 27
      change_context.old_lineno = 2
      change_context.new_lineno = 2
      change_context.old_contextual_ast = old_contextual_ast
      change_context.new_contextual_ast = new_contextual_ast

      expect(subject.supports_change(change_context)).to be_truthy
    end

    it 'supports image change' do
      old_source_ast = MetaCommit::Extension::MarkdownSupport::Parsers::Markdown.new.parse("line\ntext [domain title](http://domain.test) text\nline")
      old_contextual_ast = ContextualNodeCreator.new.create_ast_path(old_source_ast, 2)
      new_source_ast = MetaCommit::Extension::MarkdownSupport::Parsers::Markdown.new.parse("line\ntext [domain title](http://domain.test) [![Build Status](https://travis-ci.org/usernam3/meta_commit.svg?branch=master)](https://travis-ci.org/usernam3/meta_commit) text\nline")
      new_contextual_ast = ContextualNodeCreator.new.create_ast_path(new_source_ast, 2)

      change_context = MetaCommit::Contracts::ChangeContext.new
      change_context.type = MetaCommit::Extension::MarkdownSupport::Diffs::Diff::TYPE_REPLACE
      change_context.commit_id_old = nil
      change_context.commit_id_new = nil
      change_context.old_file_path = old_file_name
      change_context.new_file_path = new_file_name
      change_context.column = 41
      change_context.old_lineno = 2
      change_context.new_lineno = 2
      change_context.old_contextual_ast = old_contextual_ast
      change_context.new_contextual_ast = new_contextual_ast

      expect(subject.supports_change(change_context)).to be_truthy
    end

  end

  describe '#string_representation' do

    it 'spots anchor target change' do
      old_source_ast = MetaCommit::Extension::MarkdownSupport::Parsers::Markdown.new.parse("line\ntext [domain title](http://domain.test) [second domain title](http://second_domain.test) text\nline")
      old_contextual_ast = ContextualNodeCreator.new.create_ast_path(old_source_ast, 2)
      new_source_ast = MetaCommit::Extension::MarkdownSupport::Parsers::Markdown.new.parse("line\ntext [domain title](http://other_domain.test) [other domain title](http://other_domain.test) text\nline")
      new_contextual_ast = ContextualNodeCreator.new.create_ast_path(new_source_ast, 2)

      change_context = MetaCommit::Contracts::ChangeContext.new
      change_context.type = MetaCommit::Extension::MarkdownSupport::Diffs::Diff::TYPE_REPLACE
      change_context.commit_id_old = nil
      change_context.commit_id_new = nil
      change_context.old_file_path = old_file_name
      change_context.new_file_path = new_file_name
      change_context.column = 27
      change_context.old_lineno = 2
      change_context.new_lineno = 2
      change_context.old_contextual_ast = old_contextual_ast
      change_context.new_contextual_ast = new_contextual_ast

      subject.change_context = change_context

      expect(subject.string_representation).to eq('change domain title link')
    end

    it 'spots image link change' do
      old_source_ast = MetaCommit::Extension::MarkdownSupport::Parsers::Markdown.new.parse("line\ntext [domain title](http://domain.test) text\nline")
      old_contextual_ast = ContextualNodeCreator.new.create_ast_path(old_source_ast, 2)
      new_source_ast = MetaCommit::Extension::MarkdownSupport::Parsers::Markdown.new.parse("line\ntext [domain title](http://domain.test) [![Build Status](https://travis-ci.org/usernam3/meta_commit.svg?branch=master)](https://travis-ci.org/usernam3/meta_commit) text\nline")
      new_contextual_ast = ContextualNodeCreator.new.create_ast_path(new_source_ast, 2)

      change_context = MetaCommit::Contracts::ChangeContext.new
      change_context.type = MetaCommit::Extension::MarkdownSupport::Diffs::Diff::TYPE_REPLACE
      change_context.commit_id_old = nil
      change_context.commit_id_new = nil
      change_context.old_file_path = old_file_name
      change_context.new_file_path = new_file_name
      change_context.column = 41
      change_context.old_lineno = 2
      change_context.new_lineno = 2
      change_context.old_contextual_ast = old_contextual_ast
      change_context.new_contextual_ast = new_contextual_ast

      subject.change_context = change_context

      expect(subject.string_representation).to eq('change Build Status')
    end

  end
end