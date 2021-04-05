class UsersController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def show
    @user = User.friendly.find(params[:id])
    if @user.deleted_at
      not_found
    else
      @posts = @user.posts.order(created_at: :desc)
    end
  end

  def not_found
    render :not_found
  end
end
