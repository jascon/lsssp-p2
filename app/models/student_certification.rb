class StudentCertification < ActiveRecord::Base
  belongs_to :user
  belongs_to :certification

  class << self
    def by_certification(id)
      includes([:user,:certification]).where(:certification_id=>id).order('created_at DESC')
    end
    def all
      includes([:user,:certification]).order('created_at DESC')
    end
  end

end
