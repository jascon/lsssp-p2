class Coupon < ActiveRecord::Base

  class << self
    def search(query)
      if query
        where(:coupon.matches => "%#{query}%") #from meta_where gem
      else
        scoped
      end
    end

    def recent
      order('created_at DESC').limit(4)
    end
  end

end
