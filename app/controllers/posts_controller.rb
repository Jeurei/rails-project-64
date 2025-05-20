# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :set_post, only: %i[show update]
  before_action :set_categories, only: %i[new create]
  before_action :set_comments, only: %i[show]

  def index
    @posts = Post.includes(:creator).order(created_at: :desc)
  end

  def show
    @comment = @post.comments.build
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to @post, notice: t('.success')
    else
      set_categories
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: t('.success')
    else
      set_categories
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_comments
    @comments = Post.find(params[:id]).comments
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def set_categories
    @categories = Category.all
  end

  def post_params
    params.require(:post).permit(:title, :body, :category_id)
  end
end
