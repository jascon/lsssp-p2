class StudentExam < ActiveRecord::Base
  belongs_to :user
  belongs_to :certification
  has_many :active_questions,:order=>'id'


  class << self
    def completed(id)
      id.blank? ? includes([:user,:certification]).where(:complete_status=>true).order('updated_at DESC') :
          includes([:user,:certification]).where(:certification_id=>id,:complete_status=>true).order('updated_at DESC')
    end

    def pending(id)
      id.blank? ? includes([:user,:certification]).where(:complete_status=>false ,:status=>true).order('updated_at DESC') :
          includes([:user,:certification]).where(:certification_id=>id,:complete_status=>false ,:status=>true).order('updated_at DESC')
    end

    def not_yet_attempted(id)
      id.blank? ? includes([:user,:certification]).where(:status=>false).order('updated_at DESC') :
          includes([:user,:certification]).where(:certification_id=>id,:status=>false).order('updated_at DESC')
    end


    def by_status_and_certification(status,id)
      case status
        when 'completed'
          completed(id)
        when 'pending'
          pending(id)
        when 'not_yet_attempted'
          not_yet_attempted(id)
        else
          id.blank? ? includes([:user,:certification]).order('updated_at DESC') :
          includes([:user,:certification]).where(:certification_id=>id).order('updated_at DESC')
      end
    end
  end

end
