require 'net/http'
require 'rexml/document'
require 'uri'

require 'ostruct'
require 'cgi'
  
  
module Boss

  module SearchType
    %w[web images news spell].each { |e| const_set(e.upcase, e) }
  end

  module SearchService
    #Annoying inconsitency between 'spelling' and 'spell' in api
    SPELL = 'spelling'
  end

  FORMATS = %w[xml json]

  class Api

    attr_accessor :endpoint

    def initialize(app_id)
      @app_id = app_id
      @endpoint = 'http://boss.yahooapis.com/ysearch/'
    end

    def search(term, *conditions, &block)
       search_boss term, SearchType::WEB, *conditions, &block
    end

    def search_images(term, *conditions, &block)
      search_boss term, SearchType::IMAGES, *conditions, &block
    end

    def search_news(term, *conditions, &block)
      search_boss term, SearchType::NEWS, *conditions, &block
    end

    def search_web(term, *conditions, &block)
      search_boss term, SearchType::WEB, *conditions, &block
    end

    def search_spelling(term, *conditions, &block)
      search_boss term, SearchService::SPELL, *conditions, &block
    end

    private
    def search_boss(terms, search_type=SearchType::WEB, config = {})
      config = config.empty? ? Config.new : Config.new(config)
      search_results = []

      yield config if block_given?

      if config.format == 'object'
        format_as_objects=true
        config.format= "json"
      else
        format_as_objects=false
      end
        
      raise InvalidFormat unless (FORMATS.include? config.format)
      raise InvalidConfig unless (config.count>0)
      
      request = query_url terms, search_type, config
      response = Net::HTTP.get_response request

      case response.code
      when "200"
        data = response.body
      
        if format_as_objects
          search_results = ResultFactory.build search_type, data
        else
          search_results = data
        end
      else
        raise BossError, parse_error(data)
      end

      search_results
    end
    
    #TODO: parse error responses
    def parse_error(data)
      "Error contacting yahoo webservice"
    end

    protected
    def query_url(terms, search_type, config)
      #We could use URI.encode but it leaves things like ? unencoded which fails search.
      encoded_terms = CGI.escape terms
      # puts "#{@endpoint}#{search_type}/#{boss_version}/#{encoded_terms}?appid=#{@app_id}#{config.to_url}"
      "#{@endpoint}#{search_type}/#{boss_version}/#{encoded_terms}?appid=#{@app_id}#{config.to_url}"
    end

    protected
    def boss_version
      "v#{Boss::YAHOO_VERSION}"
    end

  end

end