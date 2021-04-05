class CommentsController < ApplicationController
  before_action :set_post
  before_action :set_comment, only: [:destroy]

  def new
    @notes = @post.notes
    @comment = @post.comments.build
  end

  def edit
  end

  def create
    @comment = @post.root.comments.create(comment_params.merge(author: current_user))

    if @comment.persisted?
      redirect_to @post
    else
      render :new
    end
  end

  def destroy
    @comment.destroy
    redirect_to @post
  end

  private

  def set_comment
    @comment = @post.comments.find(params[:id])
  end

  def set_post
    @post = Post.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
