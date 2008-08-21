require File.dirname(__FILE__) + '/../spec_helper'
# require File.dirname(__FILE__) + '/../../boss/api.rb'

describe Boss::Api do

  def mock_http_response(stubs={})
    mock('http_response', {:body => '{"ysearchresponse":{}}', :code => "200"}.merge(stubs))
  end

  before(:each) do
    @api = Boss::Api.new( appid = 'test' )
    @api.endpoint = 'http://www.example.com/'
  end

  describe "responding to spelling search" do

    it "should make a spelling request to yahoo service" do
      Net::HTTP.should_receive(:get_response).and_return{ mock_http_response }

      @api.search_spelling("girafes")
    end

    it "should build the spelling objects" do
      Net::HTTP.stub!(:get_response).and_return{ mock_http_response }
      Boss::ResultFactory.should_receive(:build).with(Boss::SearchService::SPELL, '{"ysearchresponse":{}}')

      @api.search_spelling("girafes")
    end

  end

  describe "responding to news search" do
    it "should make a news request to yahoo service" do
      Net::HTTP.should_receive(:get_response).and_return{ mock_http_response }

      @api.search_news("monkey")
    end

    it "should build the news objects" do
      Net::HTTP.stub!(:get_response).and_return{ mock_http_response }
      Boss::ResultFactory.should_receive(:build).with(Boss::SearchType::NEWS, '{"ysearchresponse":{}}')

      @api.search_news("monkey")
    end
  end

  describe "responding to image search" do
    it "should make a image request to yahoo service" do
      Net::HTTP.should_receive(:get_response).and_return{ mock_http_response }

      @api.search_images("hippo")
    end

    it "should build the image objects" do
      Net::HTTP.stub!(:get_response).and_return{ mock_http_response }
      Boss::ResultFactory.should_receive(:build).with(Boss::SearchType::IMAGES, '{"ysearchresponse":{}}')

      @api.search_images("hippo")
    end
  end

  describe "responding to web search" do

    it "should make a web request to yahoo service" do
      Net::HTTP.should_receive(:get_response).and_return{ mock_http_response }

      @api.search_web("monkey")
    end

    it "should build the web objects" do
      Net::HTTP.stub!(:get_response).and_return{ mock_http_response }
      Boss::ResultFactory.should_receive(:build).with(Boss::SearchType::WEB, '{"ysearchresponse":{}}')

      @api.search_web("monkey")
    end

  end

  describe "failed search" do

    it "should raise error on failed search" do
      Net::HTTP.stub!(:get_response).and_return{ mock_http_response :code => "404" }

      lambda { @api.search_web("monkey")  }.should raise_error(Boss::BossError)
    end

  end

  describe "configuring search" do

    before(:each) do
      Net::HTTP.stub!(:get_response).and_return{ mock_http_response }

      @config = Boss::Config.new
    end

    it "should allow configuring through block" do
      @config.should_receive(:count=).with(1)
      Boss::Config.should_receive(:new).and_return(@config)

      result = @api.search_web("monkeys") do |setup|
        setup.count = 1
      end
    end

    it "should allow configuring through hash" do
      Boss::Config.should_receive(:new).with({:count => 1}).and_return(@config)

      @api.search_web("monkeys", :count => 1)
    end

  end

  describe "formats" do

    before(:each) do
      Net::HTTP.stub!(:get_response).and_return{ mock_http_response }
    end

    it "should not return any objects when format is 'xml'" do
      Boss::ResultFactory.should_receive(:build).never
      @api.search_web("monkeys", :format => 'xml', :count => 1)
    end

    it "should not return any objects when format is 'json'" do
      Boss::ResultFactory.should_receive(:build).never
      @api.search_web("monkeys", :format => 'json', :count => 1)
    end

    it "should raise an error invalid format" do
      lambda { @api.search_web("monkeys", :format => 'grilled_cheese', :count => 1) }.should raise_error(Boss::InvalidFormat)
    end

    it "should raise an error on invalid count" do
      lambda { @api.search_web("monkeys", :count => 0) }.should raise_error(Boss::InvalidConfig)
    end

  end

  describe "search should still work when get returns a successful but not code 200" do
    it "should description" do
      pending("fix for http://eshopworks.lighthouseapp.com/projects/15732/tickets/1")
      Net::HTTP.stub!(:get_response).and_return{ mock_http_response :code => "206" }

      lambda { @api.search_web("monkey")  }.should_not raise_error(Boss::BossError)
    end
  end

  describe "searching terms" do
    it "should encode invalid characters" do
      Net::HTTP.stub!(:get_response).and_return{ mock_http_response }
      CGI.stub!(:escape)
      CGI.should_receive(:escape).with('monkey?magic').and_return('monkey%3Fmagic')
      
      @api.search_web("monkey?magic")
    end
    
  end

end