require 'spec_helper'

describe MetaCommit::Extension::MarkdownSupport::Models::Ast do
  describe '#initialize' do

    it 'depends on parsed element' do
      element = {type: 'type', value: "element's value", children: []}
      ast = MetaCommit::Extension::MarkdownSupport::Models::Ast.new(element)
      expect(ast.element).to eq(element)
    end

  end

  describe '#children' do

    it 'has children nodes' do
      contents = file_fixture('paragraphs_sample')
      ast = MetaCommit::Extension::MarkdownSupport::Parsers::Markdown.new.parse(contents)
      expect(ast.children).not_to be_empty
    end

  end

  describe '#first_line' do

    it 'returns first line of element' do
      contents = file_fixture('paragraphs_sample')
      ast = MetaCommit::Extension::MarkdownSupport::Parsers::Markdown.new.parse(contents)
      expect(ast.first_line).to eq(1)
    end

  end

  describe '#last_line' do

    it 'counts to the last line of multiline ast' do
      contents = file_fixture('paragraphs_sample')
      ast = MetaCommit::Extension::MarkdownSupport::Parsers::Markdown.new.parse(contents)
      expect(ast.last_line).to eq(8)
    end

    it 'returns last line number of last child' do
      contents = "The MIT License (MIT)\n\nCopyright (c)\n\nPermission is hereby granted, free of charge, to any person obtaining a copy"
      ast = MetaCommit::Extension::MarkdownSupport::Parsers::Markdown.new.parse(contents)
      expect(ast.last_line).to eq(5)
    end

  end

  describe '#first_column' do
    let(:contents) { " text [title](target) text after\n# header\nlast line" }

    it 'returns first column of element' do
      ast = MetaCommit::Extension::MarkdownSupport::Parsers::Markdown.new.parse(contents)
      expect(ast.first_column).to eq(0)
    end

    it 'returns first column from line start' do
      ast = MetaCommit::Extension::MarkdownSupport::Parsers::Markdown.new.parse(contents)
      expect(ast.children.last.first_column).to eq(0)
    end

    it 'returns first column when element has offset' do
      ast = MetaCommit::Extension::MarkdownSupport::Parsers::Markdown.new.parse(contents)
      expect(ast.children.first.children[1].first_column).to eq(6)
    end

  end

  describe '#last_column' do
    let(:contents) { " text [title](target)\n# header\nlast line" }

    it 'returns last column of element' do
      ast = MetaCommit::Extension::MarkdownSupport::Parsers::Markdown.new.parse(contents)
      expect(ast.children.first.last_column).to eq(20)
    end

    it 'returns last column from line start' do
      ast = MetaCommit::Extension::MarkdownSupport::Parsers::Markdown.new.parse(contents)
      expect(ast.children.last.last_column).to eq(8)
    end

    it 'returns last column when element has other contents after' do
      ast = MetaCommit::Extension::MarkdownSupport::Parsers::Markdown.new.parse(contents)
      expect(ast.children.first.children[1].last_column).to eq(20)
    end

  end

  describe '==' do

    it 'compares with other ast by element value' do
      element = MetaCommit::Extension::MarkdownSupport::Parsers::Markdown.new.parse('hello world')

      ast_left = MetaCommit::Extension::MarkdownSupport::Models::Ast.new(element)
      ast_right = MetaCommit::Extension::MarkdownSupport::Models::Ast.new(element)

      expect(ast_left == ast_right).to be_truthy
    end

  end
end