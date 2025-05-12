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
    assert_not_nil assigns(:categories)
  end

  test 'should create post' do
    assert_difference('Post.count') do
      post posts_url, params: {
        post: {
          title: 'Test Post',
          body: Faker::Lorem.paragraph_by_chars(number: 256),
          category_id: @category.id
        }
      }
    end

    assert_redirected_to "#{post_path(Post.last)}?locale=en"
    assert_equal 'Test Post', Post.last.title
    assert_equal @user, Post.last.creator
  end

  test 'should show post' do
    get post_url(@post)
    assert_response :success
  end

  test 'should update post' do
    patch post_url(@post), params: {
      post: {
        title: 'Updated Title',
        body: Faker::Lorem.paragraph_by_chars(number: 256),
        category_id: @category.id
      }
    }
    assert_redirected_to "#{post_path(@post)}?locale=en"
    @post.reload
    assert_equal 'Updated Title', @post.title
  end
end
