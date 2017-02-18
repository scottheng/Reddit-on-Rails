class PostsController < ApplicationController
  before_action :require_login, except: [:show]
  before_action :check_user_id, only: [:edit, :destroy]

  def new
    render :new

  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to post_url(@post)
    else
      redirect_to new_post_url
    end
  end

  def show
    @post = Post.find_by(id: params[:id])
    if @post
      render :show
    else
      redirect_to subs_url
    end

  end

  def edit
    @post = Post.find_by(id: params[:id])
    if @post
      render :edit
    else
      redirect_to new_post_url
    end
  end

  def update
    @post = Post.find_by(id: params[:id])
    if @post && @post.update(post_params)
      redirect_to post_url(@post)
    else
      redirect_to edit_post_url(@post)
    end

  end

  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy
    redirect_to sub_url(@post.sub)
  end

  private
  def post_params
    params.require(:post).permit(:title, :url, :content, :author_id, sub_ids: [])
  end

  def check_user_id
    post = Post.find_by(id: params[:id])
    if post.author_id != current_user.id
      redirect_to post_url(post)
    end
  end
end
