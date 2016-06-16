# Ruby core libraries

require "json"
require "yaml"
require "open3"

# Ruby gems

begin
  # for development
  require "pry-byebug"
rescue LoadError
end

# Application code

require "mugatu/todd/hash_helpers"
require "mugatu/todd/system"
require "mugatu/zipdisk"
require "mugatu/bootloader"
require "mugatu/application"
require "mugatu/runtime"
require "mugatu/changesets/null_changeset"
require "mugatu/changesets/changeset_since_ref"
require "mugatu/formatters/pretty"
require "mugatu/formatters/json"
require "mugatu/problem"
require "mugatu/version"
require "mugatu/matcher"
require "mugatu/processor_builder"
require "mugatu/processor"
require "mugatu/registry"
require "mugatu/diff"
require "mugatu/diff_parser"
require "mugatu/drivers/rubocop_driver"
