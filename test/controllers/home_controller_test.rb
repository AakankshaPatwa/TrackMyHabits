require "test_helper"

class HomeControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create!(email: "test@example.com", password: "password123")
    post user_session_path, params: {
      user: {
        email: @user.email,
        password: "password123"
      }
    }
  end

  test "should get index" do
    get root_url
    assert_response :success
  end
end
