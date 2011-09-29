class ExamNotifier < ActionMailer::Base
  default :from => "support@lsssp.org"

  def exam_notification(user,owned_certification)
    @user = user
    @owned_certification = owned_certification
    mail(:to=>@user.email,:subject => "LSSSP Examination(s) Assigned to You")
  end

  def exam_result(user,student_examination)
    @user = user
    @student_examination = student_examination
    mail(:to=>@user.email,:subject=>"Your Score Card",:from=>"admin@lsssp.org")
  end

  def reset_password(user)
    @user = user
    mail(:to=>@user.email,:subject =>"Your LSSSP password is reset")
  end

end
