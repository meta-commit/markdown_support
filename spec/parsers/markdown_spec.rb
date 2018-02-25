require 'spec_helper'

describe MetaCommit::Extension::MarkdownSupport::Parsers::Markdown do

  describe '.supported_file_extensions' do

    it 'supports markdown file extensions' do
      expect(subject.class.supported_file_extensions).to_not be_empty
    end

  end

  describe '.supports_syntax?' do

    it 'supports markdown syntax' do
      expect(subject.class.supports_syntax?(file_fixture('paragraphs_sample'))).to be true
    end

    it 'does not support non utf8 encoding' do
      skip
    end

  end

  describe '#parse' do

    it 'parses markdown' do
      parsed = subject.parse(file_fixture('paragraphs_sample'))
      expect(parsed).to be_an_instance_of(MetaCommit::Extension::MarkdownSupport::Models::Ast)
    end

  end

end