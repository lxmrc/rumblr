class CommentsController < ApplicationController
  before_action :set_post
  before_action :set_comment, only: [:destroy]

  def new
    @comments = @post.comments.order(created_at: :desc)
    @comment = @post.comments.build
  end

  def edit
  end

  def create
    @comment = @post.comments.build(comment_params)
    @comment.author = current_user

    if @comment.save
      redirect_to @post, notice: 'Comment was successfully created.'
    else
      render :new
    end
  end

  def destroy
    @comment.destroy
    redirect_to @post, notice: 'Comment was deleted.'
  end

  private
    def set_comment
      @comment = Comment.find(params[:id])
    end

    def set_post
      @post = Post.find(params[:post_id])
    end

    def comment_params
      params.require(:comment).permit(:body)
    end
end
