class CertificateProvider < ActiveRecord::Base
  belongs_to :certification
  belongs_to :provider, :class_name => 'User'

  # getting certifications user don't subscribed already
  def self.un_subscribed_certifications(c_ids)
    c_ids.blank? ? scoped : where('certification_id not in (?)',c_ids)
  end
end
