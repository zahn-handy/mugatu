$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'mugatu'

require 'minitest/autorun'
require_relative "support/declarative"

class TestCase < Minitest::Test
  extend Support::Declarative
end
