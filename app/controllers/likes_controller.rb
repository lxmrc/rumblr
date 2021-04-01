class LikesController < ApplicationController
  before_action :set_post
  before_action :set_like

  def create
    @post.likes.create(user: current_user) unless @like.present?
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @like.destroy if @like.present?
    respond_to do |format|
      format.js
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def set_like
    @like = Like.find_by(user: current_user, post: @post)
  end
end
