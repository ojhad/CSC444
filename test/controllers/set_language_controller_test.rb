require 'test_helper'

class SetLanguageControllerTest < ActionDispatch::IntegrationTest
  test "should get english" do
    get set_language_english_url
    assert_response :success
  end

  test "should get french" do
    get set_language_french_url
    assert_response :success
  end

end
