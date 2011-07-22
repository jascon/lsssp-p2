require 'test_helper'

class SubtopicTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Subtopic.new.valid?
  end
end
