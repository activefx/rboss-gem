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

        if json_hash.has_key? 'Error'
          raise BossError, "Web service error"
        end

        search_results=[]
                
        if has_results json_hash, :for => search_type

          json_hash[SEARCH_RESPONSE]["#{RESULT_SET}_#{search_type}"].each do |result|

            case search_type
            when SearchType::WEB
              search_results << Result::Web.new(result)
            when SearchType::IMAGES
              search_results << Result::Image.new(result)
            when SearchType::NEWS
              search_results << Result::News.new(result)
            when SearchType::SPELL
              search_results << Result::Spell.new(result)
            end

          end
        end

        search_results
      end

      def has_results(json_hash, type={})
        !(json_hash[SEARCH_RESPONSE]["#{RESULT_SET}_#{type[:for]}"]).nil?
      end

    end

  end

end
