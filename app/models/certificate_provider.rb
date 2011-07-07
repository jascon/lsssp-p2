class CertificateProvider < ActiveRecord::Base
  belongs_to :user
  belongs_to :certification
end
