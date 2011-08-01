#----------------------------------------------
# Author : Upender (upender@jasita.com)
# Updated : 21-06-2011
#-----------------------------------------------
module ApplicationHelper

  def tab_heading(heading)
    content = ""
    content << "<a href='#'>"
    content << "<div class='menu-l'>&nbsp;</div><div class='menu-c'><span>&nbsp;&nbsp;#{heading}&nbsp;&nbsp;&nbsp;</span></div>"
    content << "<div class='menu-r'>&nbsp;</div></a>"
    content.html_safe
  end
  def sub_heading(main,sub)
    "<h3>#{main}<span>&nbsp;|&nbsp;#{sub}</span></h3>".html_safe
  end

  def associated_names(records)
    return 'No records found' if records.blank?
    content = ''
    i = 1
    for record in records
      content << "#{i}. " + record.name + "<br/>"
      i += 1
    end
    content.html_safe
  end

  def users_list(users)
    return 'No Users found' if users.blank?
    content = ''
    i = 1
    for user in users[0..15]
      content << "#{i}. " + user.email + "<br/>"
      i += 1
    end
    content << 'and more' if users.size > 16
    content.html_safe
  end

  def certification_subtopics(subtopic_questions)
    return 'No records found' if subtopic_questions.blank?
    content = ''
    i = 1
    for subtopic_question in subtopic_questions
      content << "#{i}. " + subtopic_question.subtopic.name + "(#{subtopic_question.total_questions})" + "<br/>"
      i += 1
    end
    content.html_safe
  end
## alias for submit_tag ########
=begin
  def button_for(name, options={})
    return content_tag(:button, content_tag(:span, name), :class => options[:class], :type => options[:button_type])
  end
=end

end
