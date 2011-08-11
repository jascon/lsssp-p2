class CertificateProvider < ActiveRecord::Base
  belongs_to :certification
  belongs_to :provider, :class_name => 'User'
end
