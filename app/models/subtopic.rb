class Subtopic < ActiveRecord::Base
  #attr_accessible :topic_id, :name
  belongs_to :topic #, :counter_cache => true
  has_many :questions

  validates :topic_id, :presence => true
  validates :name,:presence=>true, :uniqueness => true, :length => { :maximum => 50 }


  #------------------------------------------------------------------------------------------------------
  # Class Methods
  #Scopes are dead in Rails3(from ref: http://www.railway.at/2010/03/09/named-scopes-are-dead/)
  #So use class methods instead
  #------------------------------------------------------------------------------------------------------
  class << self
    def search(query,topicid,status)
     #TODO implement logic

      if query.nil? && topicid.nil? && status == 'all'
        puts "##############  2"
        scoped

      elsif !query.nil? && topicid.nil? && status == 'all'
        puts "##############  3"
        where(:name.matches => "%#{query}%")
      elsif !query.nil? && topicid.nil? && status != 'all'
        puts "##############  4"
        where(:name.matches => "%#{query}%").active(status.to_i)
      elsif  !query.nil? && !topicid.nil? && status != 'all'
        puts "##############  5"
        where(:name.matches => "%#{query}%").with_topic(topicid).active(status.to_i)
      elsif query.nil? && !topicid.nil? && status != 'all'
        with_topic(topicid).active(status.to_i)
        elsif query.nil? && !topicid.nil? && status == 'all'
        with_topic(topicid)
      elsif query.nil? && topicid.nil? && status != 'all'
        active(status.to_i)
      else
        puts "##############  6"

        scoped
      end

    end

    def recent
      order('created_at DESC').limit(4)
    end

    def with_topic(id)
      where(:topic_id => id)
    end

    def active(status = true )
      where(:active => status ).order('name')
    end
  end
#------------------------------------------------------------------------------------------------------
end
