require 'net/http'
require 'rexml/document'
require 'uri'

require 'cgi'
  
module Boss

  class Api

    attr_accessor :endpoint

    def initialize(app_id)
      @app_id = app_id
      @endpoint = 'http://boss.yahooapis.com/ysearch/'
    end

    def search(term, *conditions, &block)
       search_boss(term, SearchService::WEB, *conditions, &block)
    end

    def search_images(term, *conditions, &block)
      search_boss(term, SearchService::IMAGES, *conditions, &block)
    end

    def search_news(term, *conditions, &block)
      search_boss(term, SearchService::NEWS, *conditions, &block)
    end

    def search_web(term, *conditions, &block)
      search_boss(term, SearchService::WEB, *conditions, &block)
    end

    def search_spelling(term, *conditions, &block)
      search_boss(term, SearchService::SPELLING, *conditions, &block)
    end

    private
    def search_boss(terms, search_type=SearchService::WEB, config = {})
      config = config.empty? ? Config.new : Config.new(config)
      yield config if block_given?
  
      raise InvalidFormat, "'#{config.format}' is not a valid format. Valid formats are: #{FORMATS.join(',')}" unless FORMATS.include?(config.format) || config.format?
      raise InvalidConfig, "count must be > 0" unless config.count>0
      raise InvalidConfig, "App ID cannot be empty!" if @app_id.empty?
      
      request =  URI.parse(build_request_url(terms, search_type, config))
      response = Net::HTTP.get_response(request)

      case response.code
      when "200"
        data = response.body
      
        if config.format?
          search_results = ResultFactory.build(data)
        else
          search_results = data
        end
      else
        raise BossError, parse_error(response)
      end

      search_results
    end
    
    private
    def parse_error(data)
      doc = REXML::Document.new(data.body) 
      # message = doc.elements['Error/Message'].text
      message = REXML::XPath.first( doc, "//Message" )
      if message
        message.text
      else
        "Error contacting Yahoo Boss web-service"
      end
    end

    private
    def build_request_url(terms, search_type, config)
      #We could use URI.encode but it leaves things like ? unencoded which fails search.
      encoded_terms = CGI.escape(terms)
      # puts "#{@endpoint}#{search_type}/#{boss_version}/#{encoded_terms}?appid=#{@app_id}#{config.to_url}"
      "#{@endpoint}#{search_type}/#{boss_version}/#{encoded_terms}?appid=#{@app_id}#{config.to_url}"
    end

    private
    def boss_version
      "v#{Boss::YAHOO_VERSION}"
    end

  end

end