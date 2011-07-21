require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Mailjetter::ApiRequest do

  describe "#request_url" do
    let(:request) { Mailjetter::ApiRequest.new('method_name') }
    it "should return the url of the method" do
      request.send(:request_url).to_s.should == 'https://api.mailjet.com/0.1/methodName'
    end

    it "should respect api_version" do
      Mailjetter.config.stub(:api_version).and_return(0.2)
      request.send(:request_url).to_s.should == 'https://api.mailjet.com/0.2/methodName'
    end

    it "should respect use_https" do
      Mailjetter.config.stub(:use_https).and_return(false)
      request.send(:request_url).to_s.should == 'http://api.mailjet.com/0.1/methodName'
    end
  end

  describe "#request" do
    it "should return an Http request" do
      request = Mailjetter::ApiRequest.new('method_name', {}, 'Post')
      request.send(:request).should be_a(Net::HTTP::Post)

      request = Mailjetter::ApiRequest.new('method_name', {}, 'Get')
      request.send(:request).should be_a(Net::HTTP::Get)
    end
  end

  describe "#response" do
    it "should raise an ApiError if authentication fails" do
      request = Mailjetter::ApiRequest.new('method_name', {}, 'Get')
      expect {
        request.response
      }.to raise_error(Mailjetter::ApiError)
    end

    it "should return a Hash with response values if request is ok" do
      request = Mailjetter::ApiRequest.new('user_infos', {}, 'Get')
      response = request.response
      response.should be_a(Hash)
      response['infos']['username'].should be_a(String)
    end
  end
end
