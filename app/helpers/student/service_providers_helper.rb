module Student::ServiceProvidersHelper

  def offered_certifications(certifications)
    content = ''
    for certification in certifications
      content << certification.name + "<br/>"
    end
    content.html_safe
  end

  def examination_info(certification)
    exam = certification.examination
    content = ''
    content << "Exam : #{exam.name} <br/>"
    content << "Duration : #{exam.duration} min <br/>"
    content << "Positive marks : #{exam.positive_marks} <br/>"
    content << "Negative marks : #{exam.negative_marks} <br/>"
  end
end
