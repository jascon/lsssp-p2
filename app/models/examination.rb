#Author: Chaitanya
#===============================================
class Examination < ActiveRecord::Base
  has_many :certifications,:dependent => :destroy

  #validations
  validates :name,:price,:discount_price,:presence=>true
  validates_length_of :description, :maximum => 1000, :allow_blank => true

  #others
   class << self
    def search(query)
      if query
        where(:name.matches => "%#{query}%") #from meta_where gem
      else
        scoped
      end
    end

    def recent
      order('created_at DESC').limit(4)
    end
         def active
      where(:active => true).order('name')
    end
  end
end
