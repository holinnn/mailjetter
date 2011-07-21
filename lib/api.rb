# encoding: utf-8

module Mailjetter
  class Api
    def initialize(api_key = Mailjetter.config.api_key, secret_key = Mailjetter.config.secret_key)
      @api_key = api_key
      @secret_key = secret_key
    end

    def method_missing(method_name, *args, &block)
      params, request_type = args
      request = ApiRequest.new(method_name, params, request_type, @api_key, @secret_key)
      request.response
    end
  end
end