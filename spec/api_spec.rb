# encoding: utf-8

require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Mailjetter::Api do
  let(:api) { Mailjetter::Api.new }

  describe "#method_missing" do
    it "should create an ApiRequest" do
      request = mock('request', :response => true)
      Mailjetter::ApiRequest.should_receive(:new).with(:user_infos ,{:param1 => 1}, 'Post', Mailjetter.config.api_key, Mailjetter.config.secret_key).and_return(request)
      api.user_infos({:param1 => 1}, 'Post')
    end
  end
end