require "bundler/setup"
require "byebug"
require "meta_commit_markdown_support"

require "support/file_reader"
require "support/contextual_node_creator"

RSpec.configure do |config|
  config.mock_framework = :rspec
end
