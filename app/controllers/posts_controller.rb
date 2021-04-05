class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :edit, :create, :update, :destroy]
  before_action :authorize_user, only: [:edit, :update, :destroy]

  def index
    @posts = Post.all
  end

  def show
    @comments = @post.comments.order(created_at: :desc)
  end

  def new
    @post = current_user.posts.build
  end

  def edit
    if current_user != @post.author
      redirect_to @post, notice: "That doesn't belong to you."
    end
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to current_user, notice: "Post was successfully created."
    else
      render :new
    end
  end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: "Post was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to current_user, notice: "Post was successfully destroyed."
  end

  def new_reblog
    @parent = Post.find(params[:id])
    @post = @parent.children.build(author: current_user)
  end

  def create_reblog
    @parent = Post.find(params[:id])
    @post = @parent.children.build(post_params)
    @post.author = current_user

    if @post.save
      @note = PostNote.create(post_id: @parent.root.id, note_id: @post.id, note_type: "Post")
      redirect_to @post
    else
      render :new_reblog
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content, :parent_id)
  end

  def authorize_user
    current_user == @post.author
  end
end
