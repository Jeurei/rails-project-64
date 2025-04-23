require "test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @post = posts(:one)
    @user = users(:one)
    @category = categories(:one)
    sign_in @user
  end

  test "should get index" do
    get posts_url
    assert_response :success
  end

  test "should get new" do
    get new_post_url
    assert_response :success
    assert_not_nil assigns(:categories)
  end

  test "should create post" do
    assert_difference("Post.count") do
      post posts_url, params: {
        post: {
          title: "Test Post",
          body: "Test Body",
          category_id: @category.id
        }
      }
    end

    assert_redirected_to post_url(Post.last)
    assert_equal "Test Post", Post.last.title
    assert_equal @user, Post.last.creator
  end

  test "should show post" do
    get post_url(@post)
    assert_response :success
  end

  test "should update post" do
    patch post_url(@post), params: {
      post: {
        title: "Updated Title",
        body: "Updated Body",
        category_id: @category.id
      }
    }
    assert_redirected_to post_url(@post)
    @post.reload
    assert_equal "Updated Title", @post.title
  end
end
