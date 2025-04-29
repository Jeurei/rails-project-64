# frozen_string_literal: true

class MainControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get root_url
    assert_response :success
    assert_not_nil assigns(:posts)
    assert_template :index
  end

  test 'should list all posts' do
    post1 = posts(:one)
    post2 = posts(:two)

    get root_url
    assert_response :success

    assert_match post1.title, @response.body
    assert_match post2.title, @response.body
  end
end
