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

  def link_to_exam(student_exam)
    if student_exam.status == false
      link_to content_tag(:span,'Take Test'),exam_path(:id =>student_exam.id,:status=>'new'),
              :class=>'btn-blue tipTip',:title=>'Write the exam online.',:style=>'float:right;'
    elsif student_exam.status? and !student_exam.complete_status?
      link_to content_tag(:span,'Resume Test'),exam_path(:id =>student_exam.id,:status=>'retake'),
              :class=>'btn-yellow tipTip',:title=>'No yet Completed,Go through previous session.',:style=>'float:right;'
    else
      link_to content_tag(:span,'Review the Test'),finish_exam_path(:id =>student_exam.id),
              :class=>'btn-red tipTip',:title=>'Already Completed ,go through review the questions.',:style=>'float:right;'
    end
  end

  def link_to_avatar(user)
    link_to image_tag('avatar.gif') ,'#'
  end

end
