class OwnedCertification < ActiveRecord::Base
  belongs_to :certification
  belongs_to :owned, :class_name => 'User'
  belongs_to :provider, :class_name => 'User'
  has_one :student_exam  , :dependent => :destroy
  has_many :student_assignments

  class << self

    def search(id,exam_status,issue_status)
      by_certification(id).exam_status(exam_status).issue_status(issue_status)
    end

    def by_certification(id)
      if id.blank?
        scoped
      else
        where(:certification_id=>id).order('created_at DESC')
      end
    end

    # Owned Certifications do not have at least  one student assignments(not assigned any assignment)
    def pending_assignments(assessor,certification_id = nil)
      if certification_id.nil?
        joins(:owned).where(:issued=>false,:owned=>{:id=>assessor.students})
      else
        joins(:owned).by_certification(certification_id).where(:issued=>false,:owned=>{:id=>assessor.students})
      end
    end

    #Owned Certifications have at least one assignment(so assessor managge the assignments)
    def manage_assignments(assessor,certification_id = nil)
      if certification_id.nil?
         joins([:student_assignments,:owned]).where(:issued=>false,:owned=>{:id=>assessor.students},:student_assignments=>{:assigner_id=>assessor}).group('student_assignments.owned_certification_id')
      else
        joins([:student_assignments,:owned]).by_certification(certification_id).
            where(:issued=>false,:owned=>{:id=>assessor.students},:student_assignments=>{:assigner_id=>assessor}).group('student_assignments.owned_certification_id')
      end
    end

    def exam_status(status)
      case status
        when 'completed'
          joins(:student_exam).where(:student_exam => {:complete_status=>true})
        when 'pending'
          joins(:student_exam).where(:student_exam => {:complete_status=>false ,:status=>true })
        when 'not_yet_attempted'
          joins(:student_exam).where(:student_exam => {:status=>false })
        else
          scoped
      end
    end

    def issue_status(status)
      if status == 'issued'
        where(:issued=>true)
      elsif status == 'not_issued'
        where(:issued=>false)
      else
        scoped
      end
    end
  end

end
