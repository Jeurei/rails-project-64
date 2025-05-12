# frozen_string_literal: true

class MainController < ApplicationController
  def index
    @posts = Post.includes(:creator).order(created_at: :desc)
  end
end
