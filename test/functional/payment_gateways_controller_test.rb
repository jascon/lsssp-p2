require 'test_helper'

class PaymentGatewaysControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => PaymentGateway.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    PaymentGateway.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    PaymentGateway.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to payment_gateway_url(assigns(:payment_gateway))
  end

  def test_edit
    get :edit, :id => PaymentGateway.first
    assert_template 'edit'
  end

  def test_update_invalid
    PaymentGateway.any_instance.stubs(:valid?).returns(false)
    put :update, :id => PaymentGateway.first
    assert_template 'edit'
  end

  def test_update_valid
    PaymentGateway.any_instance.stubs(:valid?).returns(true)
    put :update, :id => PaymentGateway.first
    assert_redirected_to payment_gateway_url(assigns(:payment_gateway))
  end

  def test_destroy
    payment_gateway = PaymentGateway.first
    delete :destroy, :id => payment_gateway
    assert_redirected_to payment_gateways_url
    assert !PaymentGateway.exists?(payment_gateway.id)
  end
end
