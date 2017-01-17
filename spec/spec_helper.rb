if RUBY_ENGINE == 'ruby'
  require 'simplecov'
  SimpleCov.start do
    add_filter "/spec/"
  end
end

begin
  require 'byebug'
rescue LoadError; end

SPEC_ROOT = Pathname(__FILE__).dirname

require 'erb'
require 'slim'

# Prefer plain ERB processor rather than erubis (which has problems on JRuby)
require 'tilt'
Tilt.register 'erb', Tilt::ERBTemplate

require 'dry-view'

RSpec.configure do |config|
  config.disable_monkey_patching!

  config.order = :random
  Kernel.srand config.seed
end

RSpec::Matchers.define :part_including do |data|
  match { |actual|
    data.all? { |(key, val)|
      actual._data[key] == val
    }
  }
end
