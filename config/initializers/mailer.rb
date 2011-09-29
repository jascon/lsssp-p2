ActionMailer::Base.smtp_settings = {
  :address              => "mail.lsssp.org",
  :port                 => 25,
  :domain               => "lsssp.org",
  :user_name            => "support+lsssp.org",
  :password             => "lsssp123",
  :authentication       => :login,
  :enable_starttls_auto => false
}

ActionMailer::Base.delivery_method = :smtp