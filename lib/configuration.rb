# encoding: utf-8

require 'active_support/core_ext/module/attribute_accessors'

module Mailjetter
  module Configuration
    mattr_accessor :api_version
    @@api_version = 0.1

    mattr_accessor :api_key

    mattr_accessor :secret_key
    
    mattr_accessor :use_https
    @@use_https = true
  end
end