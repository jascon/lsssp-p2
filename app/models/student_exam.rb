class StudentExam < ActiveRecord::Base
  belongs_to :user
  belongs_to :certification
  has_many :active_questions,:order=>'id'


  class << self
    def finished
      includes([:user,:certification]).where(:complete_status=>true).order('updated_at DESC')
    end
  end

end
