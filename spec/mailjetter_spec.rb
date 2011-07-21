require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Mailjetter do
  describe "#configure" do
    it "should permit to set api keys and remember them" do
      Mailjetter.configure do |config|
        config.api_key = "1234"
        config.secret_key = "5678"
      end

      Mailjetter.config.api_key.should == "1234"
      Mailjetter.config.secret_key.should == "5678"
    end
  end
end
