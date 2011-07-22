require 'test_helper'

class Catalog::SubtopicsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => Subtopic.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    Subtopic.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    Subtopic.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to catalog_subtopic_url(assigns(:subtopic))
  end

  def test_edit
    get :edit, :id => Subtopic.first
    assert_template 'edit'
  end

  def test_update_invalid
    Subtopic.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Subtopic.first
    assert_template 'edit'
  end

  def test_update_valid
    Subtopic.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Subtopic.first
    assert_redirected_to catalog_subtopic_url(assigns(:subtopic))
  end

  def test_destroy
    subtopic = Subtopic.first
    delete :destroy, :id => subtopic
    assert_redirected_to catalog_subtopics_url
    assert !Subtopic.exists?(subtopic.id)
  end
end
