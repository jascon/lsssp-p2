require 'test_helper'

class Catalog::CertificationsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => Certification.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    Certification.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    Certification.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to catalog_certification_url(assigns(:certification))
  end

  def test_edit
    get :edit, :id => Certification.first
    assert_template 'edit'
  end

  def test_update_invalid
    Certification.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Certification.first
    assert_template 'edit'
  end

  def test_update_valid
    Certification.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Certification.first
    assert_redirected_to catalog_certification_url(assigns(:certification))
  end

  def test_destroy
    certification = Certification.first
    delete :destroy, :id => certification
    assert_redirected_to catalog_certifications_url
    assert !Certification.exists?(certification.id)
  end
end
