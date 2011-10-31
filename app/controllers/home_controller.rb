class HomeController < ApplicationController
  # before_filter :authenticate_user!
  def index

=begin
   puts "############   #{Certification.find(1).providers.size}"
   puts "############   #{User.find(2).provided_certifications.size}"

    puts "############   #{Certification.find(1).owned.size}"
   puts "############   #{User.find(62).owned.size}"
=end
  end
end
