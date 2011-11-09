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

  def sub_heading(main, sub)
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

  def associated_names1(records)
    return 'No records found' if records.blank?
    content = ''
    i = 1
    for record in records
      content << "#{i}. " + record.attachment_file_name + "<br/>"
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

  # Check question status viewed or,answered or unanswered
  def active_question_status(active_question)
    if active_question.correct_answer.nil? and active_question.viewed?
      return 'viewed'
    elsif !active_question.correct_answer.nil? and active_question.viewed?
      return 'completed'
    elsif active_question.correct_answer.nil? and !active_question.viewed?
      return 'loaded'
    end
  end

  def offered_certifications(certifications)
    content = ''
    for certification in certifications
      content << certification.name + "<br/>"
    end
    content.html_safe
  end

  def examination_info(certification)
    content = ''
    content << "Total Questions : #{certification.no_of_questions} <br/>"
    content << "Duration : #{certification.duration.to_i} min <br/>"
    content << "Positive Marks : #{certification.positive_marks} <br/>"
    content << "Negative Marks : #{certification.negative_marks} <br/>"
    content << "Un Attempted Marks : #{certification.unattempted_marks} <br/>"
  end

  def exam_status(student_exam)
    content = ''
    if student_exam.status == false
      content << "<span class='status_pending'>Not Yet Attempted</span>"
    elsif student_exam.status == true and student_exam.complete_status == false
      content << "<span class='status_pending'>Pending</span>"
    elsif student_exam.status == true and student_exam.complete_status == true
      content << "<span class='status_completed'>Completed</span>"
    end
    content.html_safe
  end

  def assignment_status(owned_certification)
    if owned_certification.student_assignments_status?
      "<span class='status_completed'>Completed</span>".html_safe
    else
      "<span class='status_pending'>Pending</span>".html_safe
    end
  end

  def assignment_result(owned_certification)
    case owned_certification.student_assignments_result
      when 'processing'
        "<span class='processing'>Pending</span>".html_safe
      when 'pass'
        "<span class='pass'>Passed</span>".html_safe
      when 'fail'
        "<span class='fail'>Failed</span>".html_safe
    end
  end

  def check_all
    "<input type='checkbox' name='checkall' id='checkall'/>".html_safe
  end


## alias for submit_tag ########
=begin
  def button_for(name, options={})
    return content_tag(:button, content_tag(:span, name), :class => options[:class], :type => options[:button_type])
  end
=end

end
