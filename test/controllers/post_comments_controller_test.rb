require "test_helper"

class PostCommentsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:one)
    @post = posts(:one)
    @parent_comment = post_comments(:with_comments)
    sign_in @user
  end

  test "should create comment" do
    assert_difference("PostComment.count") do
      post post_comments_path(@post), params: {
        post_comment: { content: "This is a test comment" }
      }
    end

    assert { PostComment.last.content == "This is a test comment" }
    assert { PostComment.last.user == @user }
    assert { PostComment.last.post == @post }
    assert { PostComment.last.ancestry == nil || PostComment.last.ancestry == "/" } 
    assert_redirected_to post_path(@post, locale: I18n.locale)
    assert_not_nil flash[:notice]
  end

  test "should create nested comment" do
    assert_difference("PostComment.count") do
      post post_comments_path(@post), params: {
        post_comment: {
          content: "This is a reply",
          parent_id: @parent_comment.id
        }
      }
    end

    new_comment = PostComment.last
    assert { new_comment.parent == @parent_comment }
    parent_id = ActiveRecord::FixtureSet.identify(:with_comments)
    expected_ancestry = "/#{parent_id}/"
    assert { new_comment.ancestry == expected_ancestry || new_comment.ancestry == "#{parent_id}" }

    assert_redirected_to post_path(@post, locale: I18n.locale)
  end

  test "should create a deeply nested comment" do
    nested_comment = post_comments(:nested)

    assert_difference("PostComment.count") do
      post post_comments_path(@post), params: {
        post_comment: {
          content: "Reply to nested comment",
          parent_id: nested_comment.id
        }
      }
    end

    new_comment = PostComment.last
    assert { new_comment.parent == nested_comment }

    parent_id = ActiveRecord::FixtureSet.identify(:with_comments)
    nested_id = ActiveRecord::FixtureSet.identify(:nested)
    expected_pattern = /#{parent_id}.*#{nested_id}/

    assert { new_comment.ancestry.match?(expected_pattern) }
    assert_redirected_to post_path(@post, locale: I18n.locale)
  end
end
