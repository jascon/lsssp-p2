class OwnedCertification < ActiveRecord::Base

  belongs_to :certification
  belongs_to :owned, :class_name => 'User'
  belongs_to :provider, :class_name => 'User'

  class << self
    def by_certification(id)
      includes([:owned,:provider,:certification]).where(:certification_id=>id).order('created_at DESC')
    end
    def all
      includes([:owned,:provider,:certification]).order('created_at DESC')
    end
  end

end
