require 'test_helper'

class CertificationTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Certification.new.valid?
  end
end
