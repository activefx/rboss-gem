require 'json'

module Boss
  class ResultFactory

    class << self

      SEARCH_RESPONSE = 'ysearchresponse'
      RESULT_SET = 'resultset'

      def build(search_type, data)

        #Deal with inconsistency between search service 'spelling' and result 'spell'
        search_type = SearchType::SPELL if search_type == SearchService::SPELL

        json_hash = JSON.parse(data)

        if json_hash.has_key? 'Error' or !json_hash.has_key? SEARCH_RESPONSE
          raise BossError, "Results from webservice appear to be mangled."
        end

        result_collection = ResultCollection.new

        json_hash[SEARCH_RESPONSE].each do |key,value|

          if key == "#{RESULT_SET}_#{search_type}"
            
            json_hash[SEARCH_RESPONSE]["#{RESULT_SET}_#{search_type}"].each do |result|

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

    end

  end
end