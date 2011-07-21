# encoding: utf-8

require 'active_support/core_ext/string/inflections'
require 'net/http'
require 'uri'
require 'json'

module Mailjetter
  class ApiRequest
    def initialize(method_name, params = {}, request_type = 'Get')
      @method_name = method_name.camelize(:lower)
      @params = params.merge(:output => 'json')
      @request_type = request_type.camelize
    end

    def response
      @response ||= begin
        http = Net::HTTP.new(request_url.host, request_url.port)
        http.use_ssl = Mailjetter.config.use_https
        res = http.request(request)
        
        case res
          when Net::HTTPSuccess
            JSON.parse(res.body)
          else
            raise ApiError.new(res.code)
        end
      end
    end

    private
    def request
      req = "Net::HTTP::#{@request_type}".constantize.new(request_url.path)
      req.basic_auth Mailjetter.config.api_key, Mailjetter.config.secret_key
      req
    end

    def request_url
      @request_url ||= begin
        url = Mailjetter.config.use_https ? 'https' : 'http'
        url << "://api.mailjet.com/#{Mailjetter.config.api_version}"
        url <<  "/#{@method_name}"

        URI.parse(url)
      end
    end
  end
end