# frozen_string_literal: true

class PostCommentsController < ApplicationController
  before_action :set_post, only: [:create]

  def create
    @post_comment = current_user.comments.build(post_comment_params.merge(post: @post))

    if params[:post_comment][:parent_id].present?
      @post_comment.parent = PostComment.find(params[:post_comment][:parent_id])
    end

    if @post_comment.save
      redirect_to @post, notice: t('.success')
    else
      redirect_to @post, alert: @post_comment.errors.full_messages.join(', ')
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def post_comment_params
    params.require(:post_comment).permit(:content, :post_id, :parent_id)
  end
end
