require 'test_helper'

class PaymentGatewayTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert PaymentGateway.new.valid?
  end
end
