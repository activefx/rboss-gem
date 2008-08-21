module Boss
  class ResultCollection 
    include Enumerable

    def initialize(search_data)
      search_data.each do |name, value|
        instance_variable_set("@#{name}",value)
        instance_eval("def #{name}\n @#{name}\n end")        
      end
      @results=[]
    end

    def each
      @results.each { |result| yield result }
    end
    
    def <<(element)
      @results << element
    end
    
    def [](key)
      @results[key]
    end

  end
end
