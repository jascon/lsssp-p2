module CustomeLinksHelper

  def link_to_edit(path)
    link_to content_tag(:span,"&uarr; Edit".html_safe), path,:class=>'btn-blue'
  end

  def link_to_delete(path)
    link_to content_tag(:span,"&darr; Delete".html_safe), path, :confirm => 'Are you sure?', :method => :delete,:class=>'btn-red'
  end

  def link_to_show(path)
    link_to content_tag(:span,"Show".html_safe), path,:class=>'btn-yellow'
  end

  def link_to_all(path)
    link_to content_tag(:span, "Back To List &rarr;".html_safe), path,:class=>'btn-gray'
  end

  def link_to_back
    link_to content_tag(:span,'&larr; Back'.html_safe),:back,:class=>'btn-ltgray'
  end

  def link_to_active(model,path)
    content = ''
    content << "<div id='active_#{model.id}'>"
    content << link_to(model.active? ? image_tag('tick.gif') : image_tag('cros.gif') ,path,:remote=>true)
    content <<  "</div>"
    content.html_safe
  end

  def link_for_edit(path)
     link_to image_tag('/images/icons/edit.png'), path,:title =>'Edit it',:class=>'tipTip'
  end

   def link_for_show(path)
     link_to image_tag('/images/icons/show.png'), path,:title =>'Show Content',:class=>'tipTipTop'
  end

  def link_for_destroy(path)
     link_to image_tag('/images/icons/delete.png'),path, :confirm => 'Are you sure?', :method => :delete,:title =>'Delete it',:class=>'tipTip'
  end

  def link_to_exam(certification_id)
    # if student already taken the exam then check for exam complete or not
    # if completed Review the exam else retake the exam from the previous session
    if current_user.student_exams.exists?(:certification_id =>certification_id)
      student_exam = current_user.student_exams.find_by_certification_id(certification_id)
      if student_exam.complete_status? #already completed review the exam
        link_to content_tag(:span,'Review'),finish_exam_path(:student_exam_id =>student_exam.id),
                :class=>'btn-red tipTip',:title=>'Already Completed ,go through review the questions.',:style=>'float:right;'
      else # not completed the retake from previous session
        link_to content_tag(:span,'Re take'),exam_path(:certification_id =>certification_id,:status=>'retake'),
                :class=>'btn-yellow tipTip',:title=>'No yet Completed,Go through previous session.',:style=>'float:right;'
      end
    else
      link_to content_tag(:span,'Take Test'),exam_path(:certification_id =>certification_id,:status=>'new'),
              :class=>'btn-blue tipTip',:title=>'Write the exam online.',:style=>'float:right;'
    end
  end

  def link_to_avatar(user)
    link_to image_tag('avatar.gif') ,'#'
  end

end
