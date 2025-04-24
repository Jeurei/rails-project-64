class PostCommentsController < ApplicationController
  before_action :set_post, only: [ :create ]

  def create
    @post_comment = current_user.comments.build(post_comment_params.merge(post: @post))

    if params[:post_comment][:parent_id].present?
      @post_comment.parent = PostComment.find(params[:post_comment][:parent_id])
    end

    respond_to do |format|
      if @post_comment.save!
        format.html { redirect_to @post, notice: t(".success") }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { redirect_to @post, alert: @post_comment.errors.full_messages.join(", ") }
        format.json { render json: @post_comment.errors, status: :unprocessable_entity }
      end
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
