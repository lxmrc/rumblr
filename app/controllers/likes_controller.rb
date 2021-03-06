class LikesController < ApplicationController
  before_action :set_post
  before_action :set_like

  def create
    @post.root.likes.create(user: current_user) unless @like.present?
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
    @like = @post.root.likes.find_by(user_id: current_user.id)
  end
end
