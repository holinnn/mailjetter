# encoding: utf-8

require 'yaml'

yaml = YAML.load_file(File.join(File.dirname(__FILE__), 'config.yml'))

Mailjetter.configure do |config|
  config.api_key = yaml['api_key']
  config.secret_key = yaml['secret_key']
end