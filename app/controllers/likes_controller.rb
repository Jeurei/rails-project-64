# frozen_string_literal: true

class LikesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :handle_record_not_found
  before_action :authenticate_user!
  before_action :set_post
  before_action :set_like, only: [:destroy]

  def create
    return unless user_signed_in?

    # Use the current_user object to ensure proper assignment
    @post.likes.find_or_create_by(user: current_user)
    redirect_to @post
  end

  def destroy
    return unless user_signed_in?

    # Check if the like belongs to the current user
    if @like && @like.user_id == current_user.id
      @like.destroy
    end
    redirect_to @post
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def handle_record_not_found
    redirect_to root_path
  end

  def set_like
    # Try to find by ID first, then by user
    @like = @post.likes.find_by(id: params[:id])
    @set_like ||= @post.likes.find_by(user: current_user.id)
  end
end
