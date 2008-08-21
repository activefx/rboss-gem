require File.dirname(__FILE__) + '/../spec_helper'

describe Boss::ResultCollection do

  it "should dynamically set instance values given at creation" do
    collection = Boss::ResultCollection.new({:totalhits => "344"})
    
    collection.totalhits.should eql("344")
  end
  
  it "should allow iterating over result collection" do
    collection = Boss::ResultCollection.new({})
    
    collection << 1
    collection << 2
    
    collection.each do |value| 
      [1,2].member?(value).should be_true
    end
    
  end
  
end