$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'rspec'
require 'mailjetter'

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

RSpec.configure do |config|
  config.before(:each) do
    load "#{File.dirname(__FILE__)}/support/configuration.rb"
  end

  config.after(:each) do
    Object.send(:remove_const, 'Mailjetter')
    Dir["#{File.dirname(__FILE__)}/../lib/**/*.rb"].each {|f| load f}
  end
end
