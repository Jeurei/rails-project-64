# frozen_string_literal: true

class MainController < ApplicationController
  def index
    @posts = Post.all
  end
end
