# Ruby core libraries

require "json"
require "yaml"

# Ruby gems

require "cocaine"

begin
  # for development
  require "pry-byebug"
rescue LoadError
end


# Application code

require "mugatu/changeset"
require "mugatu/changeset_since_ref"
require "mugatu/problem"
require "mugatu/version"
require "mugatu/rubocop_runner"
require "mugatu/rubocop_parser"
require "mugatu/bucket"
require "mugatu/file_matcher"
require "mugatu/runway"
require "mugatu/bootloader"
require "mugatu/application"
require "mugatu/fashion_show"
