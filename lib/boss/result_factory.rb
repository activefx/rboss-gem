require 'json'

module Boss
    
  class ResultFactory

    module SearchType
      %w[web images news spell].each { |e| const_set(e.upcase, e) }
    end

    SEARCH_RESPONSE = 'ysearchresponse'
    RESULT_SET = 'resultset'

    class << self
  
      def build(data)
        json_hash = JSON.parse(data)

        if json_hash.has_key? 'Error' or !json_hash.has_key? SEARCH_RESPONSE
          raise BossError, "Results from webservice appear to be mangled."
        end

        result_collection = ResultCollection.new

        json_hash[SEARCH_RESPONSE].each do |key,value|

          if key.include? "#{RESULT_SET}_"

            search_type = discover_search_type(key)
            
            json_hash[SEARCH_RESPONSE][key].each do |result|

              case search_type
              when SearchType::WEB
                result_collection << Result::Web.new(result)
              when SearchType::IMAGES
                result_collection << Result::Image.new(result)
              when SearchType::NEWS
                result_collection << Result::News.new(result)
              when SearchType::SPELL
                result_collection << Result::Spell.new(result)
              end

            end
          else
            result_collection.set_instance_variable(key, value)
          end

        end
        result_collection
      end

      private
      def discover_search_type(string)
        /#{RESULT_SET}_(.*)/.match(string)[1]
      end
      
    end

  end
end
