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
end
