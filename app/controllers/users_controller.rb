class UsersController < ApplicationController
  def show
    @user = User.friendly.find(params[:id])
    @posts = @user.posts.order(created_at: :desc)
  end
end
