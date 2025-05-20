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
    post post_likes_path(@post)
    like = PostLike.find_by(user: @user, post: @post)
    assert_nil like
    assert_redirected_to new_user_session_path
  end

  test 'should require authentication for destroy' do
    delete post_like_path(@post, 1)
    assert_redirected_to new_user_session_path
  end

  test 'should create like when user is signed in' do
    sign_in @user

    post post_likes_path(@post)

    like = PostLike.find_by(user: @user, post: @post)
    assert_not_nil like
    assert_equal @user, like.user
    assert_equal @post, like.post
    assert_redirected_to @post
  end

  test 'should destroy like when user is signed in and like exists' do
    sign_in @user

    like = @post.likes.create!(user: @user)
    delete post_like_path(@post, like)

    assert_not PostLike.exists?(like.id)
    assert_redirected_to @post
  end

  test 'should not error when trying to destroy a non-existent like' do
    sign_in @user

    delete post_like_path(@post, 999)
    assert_redirected_to @post
  end

  test 'should only destroy own likes' do
    sign_in @user

    other_user = users(:two)
    like = @post.likes.create!(user: other_user)

    delete post_like_path(@post, like)

    assert PostLike.exists?(like.id)
    assert_redirected_to @post
  end

  test 'should handle non-existent post' do
    sign_in @user

    post post_likes_path(999)

    like = PostLike.find_by(user: @user, post_id: 999)
    assert_nil like
    assert_redirected_to "#{root_path}?locale=#{I18n.locale}"
  end
end
