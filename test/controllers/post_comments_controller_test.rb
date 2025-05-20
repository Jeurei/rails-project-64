# frozen_string_literal: true

require 'test_helper'

class PostCommentsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:one)
    @post = posts(:two)
    @parent_comment = post_comments(:one)
    sign_in @user
  end

  test 'should create comment' do
    post post_comments_path(@post), params: {
      post_comment: { content: 'This is a test comment' }
    }

    comment = PostComment.find_by(content: 'This is a test comment')
    assert_not_nil comment
    assert_equal @user, comment.user
    assert_equal @post, comment.post
    assert_nil comment.parent
    assert { [nil, '/'].include?(comment.ancestry) }

    assert_redirected_to post_path(@post, locale: I18n.locale)
    assert_not_nil flash[:notice]
  end

  test 'should create nested comment' do
    post post_comments_path(@post), params: {
      post_comment: {
        content: 'This is a reply',
        parent_id: @parent_comment.id
      }
    }

    comment = PostComment.find_by(content: 'This is a reply')
    assert_not_nil comment
    assert_equal @parent_comment, comment.parent

    parent_id = @parent_comment.id
    expected_ancestry = "/#{parent_id}/"
    assert_includes [expected_ancestry, parent_id.to_s, "/#{parent_id}/"], comment.ancestry

    assert_redirected_to post_path(@post, locale: I18n.locale)
  end

  test 'should create a deeply nested comment' do
    nested_comment = post_comments(:nested)

    post post_comments_path(@post), params: {
      post_comment: {
        content: 'Reply to nested comment',
        parent_id: nested_comment.id
      }
    }

    comment = PostComment.find_by(content: 'Reply to nested comment')
    assert_not_nil comment
    assert_equal nested_comment, comment.parent

    expected_pattern = /#{@parent_comment.id}.*#{nested_comment.id}/
    assert_match expected_pattern, comment.ancestry

    assert_redirected_to post_path(@post, locale: I18n.locale)
  end
end
