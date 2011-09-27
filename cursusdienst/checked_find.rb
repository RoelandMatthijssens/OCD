module ActiveRecord
  class Base
    #class << self
      #alias_method :unchecked_find, :find
    #end
    def findchecked *p
      conditions = nil
      p.each do |e|
        if e.instance_of? Hash and conditions.nil?
          conditions = e[:conditions]
        end
      end
      if conditions
        conditions[0] = "deleted = 0 AND #{conditions[0]}"
      else
        p << {:conditions => ["deleted = 0"]}
      end
      find *p
    end
  end
end
