class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post
  before_action :set_like, only: [:destroy]

  def create
    return unless user_signed_in? # Double check authentication
    
    @like = @post.post_likes.build(user: current_user)

    respond_to do |format|
      if @like.save
        format.html { redirect_to @post, notice: 'Post was successfully liked.' }
        format.json { render json: @like, status: :created }
      else
        format.html { redirect_to @post, alert: 'Unable to like the post.' }
        format.json { render json: @like.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    return unless user_signed_in? # Double check authentication
    
    if @like&.user == current_user
      @like.destroy
      respond_to do |format|
        format.html { redirect_to @post, notice: 'Like was successfully removed.' }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to @post, alert: 'You can only remove your own likes.' }
        format.json { render json: { error: 'Unauthorized' }, status: :unauthorized }
      end
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  rescue ActiveRecord::RecordNotFound
    respond_to do |format|
      format.html { redirect_to root_path, alert: 'Post not found.' }
      format.json { render json: { error: 'Post not found' }, status: :not_found }
    end
  end

  def set_like
    @like = @post.post_likes.find_by(id: params[:id])
  end
end
