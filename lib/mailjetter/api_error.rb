# encoding: utf-8

module Mailjetter
  class ApiError < StandardError
    def initialize(code)
      super("Error #{code} see http://api.mailjet.com/#{Mailjetter.config.api_version}/doc/general/errors.html")
    end
  end
end