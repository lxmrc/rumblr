class UsersController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  before_action :set_user, only: [:show, :followers, :following]

  def show
    if @user.deleted_at
      not_found
    else
      @posts = @user.posts.order(created_at: :desc)
    end
  end

  def not_found
    render :not_found
  end

  def followers
    @title = "Followers"
    @users = @user.followers
    render 'show_follow'
  end

  def following
    @title = "Following"
    @users = @user.following
    render 'show_follow'
  end

  def feed
    @posts = current_user.feed
  end

  private 

    def set_user
      @user = User.friendly.find(params[:id])
    end
end
