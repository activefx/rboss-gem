require 'ostruct'

module Boss

  class Config < OpenStruct

    def initialize(hash={})
      #Setup defaults      
      super({:count => 10, :lang => "en", :format => "object"}.merge(hash))
    end
   
    def to_url
      self.marshal_dump.inject("") {|accum, key| encoded_value=CGI.escape(key[1].to_s); accum+="&#{key[0]}=#{encoded_value}"  }
    end

  end

end