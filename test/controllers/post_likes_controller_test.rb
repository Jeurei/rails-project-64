# frozen_string_literal: true

require 'test_helper'

class PostLikesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:one)
    @post = posts(:one)
    PostLike.destroy_all
  end

  test 'should require authentication for create' do
    assert_no_difference 'PostLike.count' do
      post post_likes_path(@post)
    end
    assert_redirected_to new_user_session_path
  end

  test 'should require authentication for destroy' do
    delete post_like_path(@post, 1)
    assert_redirected_to new_user_session_path
  end

  test 'should create like when user is signed in' do
    sign_in @user

    assert_difference 'PostLike.count', 1 do
      post post_likes_path(@post)
    end

    assert_equal @user, PostLike.last.user
    assert_equal @post, PostLike.last.post
    assert_redirected_to @post
  end

  test 'should destroy like when user is signed in and like exists' do
    sign_in @user

    like = @post.likes.create!(user: @user)

    assert_difference 'PostLike.count', -1 do
      delete post_like_path(@post, like)
    end

    assert_redirected_to @post
  end

  test 'should not error when trying to destroy a non-existent like' do
    sign_in @user

    assert_no_difference 'PostLike.count' do
      delete post_like_path(@post, 999)
    end

    assert_redirected_to @post
  end

  test 'should only destroy own likes' do
    sign_in @user

    other_user = users(:two)
    like = @post.likes.create!(user: other_user)

    assert_no_difference 'PostLike.count' do
      delete post_like_path(@post, like)
    end

    assert PostLike.exists?(like.id)
    assert_redirected_to @post
  end

  test 'should handle non-existent post' do
    sign_in @user

    assert_no_difference 'PostLike.count' do
      post post_likes_path(999)
    end

    assert_redirected_to "#{root_path}?locale=#{I18n.locale}"
  end
end
