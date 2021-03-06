# Ruby core libraries

require "json"
require "yaml"
require "open3"

# Ruby gems

require "rainbow"

begin
  # for development
  require "pry-byebug"
rescue LoadError
end

# Application code

require "mugatu/todd/hash_helpers"
require "mugatu/todd/system"
require "mugatu/zipdisk"
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
require "mugatu/config"
require "mugatu/pipes/diff"
require "mugatu/pipes/diff_parser"
require "mugatu/pipes/files"
require "mugatu/pipes/linter"
require "mugatu/pipes/filter"
require "mugatu/pipes/branch_point"
require "mugatu/pipes/init_processors"
