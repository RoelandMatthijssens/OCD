class Order < ActiveRecord::Base
  @@label = "A-000"
  class << self
    def get_label
      #file = File.new("LABEL.txt", "a+")
      #label = "A-000"
      #while (line = file.gets)
        #label = line
      #end
     #file.close
     #new_label = next_label(label)
     #file = File.open("LABEL.txt", 'a') {|f| f.write(new_label) }
     #file.close
     @@label = next_label(@@label)
     return @@label

    end

    def next_label label
      l = label.split('-')
      l[0] = "A" if l[1] == "999" and l[0] == "Z"
      l[0] = l[0].next if l[1] == "999"
      l[1] = l[1].next
      l[1] = "000" if l[1] == "1000"
      x = l.join('-')
      return x
    end
  end

  belongs_to :user
  belongs_to :institute
  has_many :material_orders
  has_many :materials, :through => :material_orders

  validates :institute, :presence => true
  validates :user, :presence => true

  def get_random_string(length)
    s = (0...length).map{ ('0'..'10').to_a[rand(10)] }.join
    x = Order.find(:all, :conditions => ['order_key=?', s])
    if x.any?
      get_random_string(length)
    else
      return s
    end
  end

  def status
    s = { 'Posted' => 1, 'Payed' => 2, 'Ordered' => 3, 'Delivered' => 4,'Ready' => 5, 'Done' => 6, 'Canceled' => 0 }
    r = 'Done'
    x = material_orders
    x.each do |i|
      r = i.status if s[i.status] < s[r]
    end
    return r
  end
end
