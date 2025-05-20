# frozen_string_literal: true

require 'test_helper'
require 'faker'

class PostsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @post = posts(:one)
    @user = users(:one)
    @category = categories(:one)
    sign_in @user
  end

  test 'should get index' do
    get posts_url
    assert_response :success
  end

  test 'should get new' do
    get new_post_url
    assert_response :success
    # Вместо assigns — проверка наличия категории в response body (если надо)
    assert_match @category.name, @response.body
  end

  test 'should create post' do
    title = 'Test Post'
    body = Faker::Lorem.paragraph_by_chars(number: 256)

    post posts_url, params: {
      post: {
        title: title,
        body: body,
        category_id: @category.id
      }
    }

    created_post = Post.find_by(title: title, body: body, category_id: @category.id, creator_id: @user.id)
    assert_not_nil created_post
    assert_redirected_to "#{post_path(created_post)}?locale=en"
  end

  test 'should show post' do
    get post_url(@post)
    assert_response :success
    assert_match @post.title, @response.body
  end

  test 'should update post' do
    new_title = 'Updated Title'
    new_body = Faker::Lorem.paragraph_by_chars(number: 256)

    patch post_url(@post), params: {
      post: {
        title: new_title,
        body: new_body,
        category_id: @category.id
      }
    }

    assert_redirected_to "#{post_path(@post)}?locale=en"
    @post.reload
    assert_equal new_title, @post.title
    assert_equal new_body, @post.body
    assert_equal @category.id, @post.category_id
  end
end
