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
  
    config.to_url.should include("&count=1")
    config.to_url.should include("&format=object")
    config.to_url.should include("&lang=en")
  end
  
  it "should add custom values to url" do
    config = Boss::Config.new :mizaru => 'cannot_see'
    
    config.to_url.should include("&mizaru=cannot_see")
  end
  
  it "should encode invalid url characters" do
    config = Boss::Config.new :mizaru => 'dancing monkeys?'
    
    config.to_url.should include("dancing+monkeys%3F")
  end
  
end