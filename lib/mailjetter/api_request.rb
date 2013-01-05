# encoding: utf-8

require 'active_support/core_ext/string/inflections'
require 'net/http'
require 'json'
require 'cgi'

module Mailjetter
  class ApiRequest
    MAILJET_HOST = 'api.mailjet.com'

    def initialize(method_name, params = {}, request_type = nil, auth_user = Mailjetter.config.api_key, auth_password = Mailjetter.config.secret_key)
      @method_name = method_name.to_s.camelize(:lower)
      @params = (params || {}).merge(:output => 'json')
      @request_type = (request_type || guess_request_type).camelize
      @auth_user = auth_user
      @auth_password = auth_password
    end

    def response
      @response ||= begin
        http = Net::HTTP.new(MAILJET_HOST, request_port)
        http.use_ssl = Mailjetter.config.use_https
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE  if http.use_ssl
        res = http.request(request)
        
        case res
          when Net::HTTPSuccess
            JSON.parse(res.body || '{}')
          else
            raise ApiError.new(res.code)
        end
      end
    end

    private
    def request
      @request ||= begin
        req = "Net::HTTP::#{@request_type}".constantize.new(request_path)
        Net::HTTP::Get
        req.basic_auth @auth_user, @auth_password
        req.set_form_data(@params)
        req
      end
    end

    def request_path
      @request_path ||= begin
        path = "/#{Mailjetter.config.api_version}/#{@method_name}"
        if @request_type == 'Get'
          path <<  '?' + @params.collect { |k,v| "#{k}=#{CGI::escape(v.to_s)}" }.join('&')
        end
        path
      end
    end

    def request_port
      Mailjetter.config.use_https ? 443 : 80
    end

    def guess_request_type
      if @method_name =~ /(?:Create|Add|Remove|Delete|Update)(?:[A-Z]|$)/
        'Post'
      else
        'Get'
      end
    end
  end
end
