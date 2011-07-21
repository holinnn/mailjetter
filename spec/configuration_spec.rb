require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Mailjetter::Configuration do
  let(:configuration) { Mailjetter::Configuration }

  describe "accessors" do
    it "should memorize values" do
      configuration.api_key = '1234'
      configuration.api_key.should == '1234'
    end
  end

  describe "#use_https" do
    it "should be true by default" do
      configuration.use_https.should == true
    end
  end
end
