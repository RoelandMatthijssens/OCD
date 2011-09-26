class ActiveModel::Base
  alias_method :unchecked_find, :find
  def find *p
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
    unchecked_find *p
  end
end
