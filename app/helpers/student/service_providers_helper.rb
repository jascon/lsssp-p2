module Student::ServiceProvidersHelper

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
    content << "Duration : #{certification.duration} min <br/>"
    content << "Positive marks : #{certification.positive_marks} <br/>"
    content << "Negative marks : #{certification.negative_marks} <br/>"
    content << "Not Attempted : #{certification.unattempted_marks} <br/>"
  end
end
