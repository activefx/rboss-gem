require 'spec'
$:.unshift(File.dirname(__FILE__) + '/../../lib')
require 'boss'

Before do
end

After do
end

Given "a valid API key" do
  @api = Boss::Api.new("put-your-api-key-here")
end

When /I do a '(.+)' search for '(.+)'/ do |search, term|

  case search
  when 'web'
    @results = @api.search_web(term)    
  when 'news'
    @results = @api.search_news(term)    
  when 'images'
    @results = @api.search_images(term)
  when 'spell'
    @results = @api.search_spelling(term)
  else
    raise Exception.new "invalid search: #{search}"
  end

end

Then /I will receive search results/ do
  @results.results.nil?.should == false
end

Then /I will be able to see the total hits/ do
  @results.totalhits.to_i.should > 0 
end
