require File.dirname(__FILE__) + '/../spec_helper'

describe Boss::Config do

  it "should create with defaults" do
    config = Boss::Config.new

    config.respond_to?(:count).should be_true
    config.respond_to?(:lang).should be_true
    config.respond_to?(:format).should be_true
  end
  
  it "should create url from defaults" do
    config = Boss::Config.new :count => 1, :lang => 'en', :format => "object"
  
    config.to_url.should == "&count=1&format=object&lang=en"
  end
  
  it "should add custom values to url" do
    config = Boss::Config.new :mizaru => 'cannot_see'
    
    config.to_url.should include("&mizaru=cannot_see")
  end
  
end