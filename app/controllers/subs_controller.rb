class SubsController < ApplicationController

  before_action :require_login, except: [:index, :show]
  before_action :check_user_id, only: [:edit, :update, :destroy]

  def new
    render :new
  end

  def create
    @sub = Sub.new(sub_params)
    if @sub.save
      redirect_to sub_url(@sub)
    else
      redirect_to new_subs_url
    end
  end

  def edit
    @sub = Sub.find_by(id: params[:id])
    if @sub
      render :edit
    else
      redirect_to subs_url
    end
  end

  def update
    @sub = Sub.find_by(id: params[:id])
    if @sub && @sub.update(sub_params)
      redirect_to sub_url(@sub)
    else
      redirect_to subs_url
    end
  end

  def index
    @subs = Sub.all
    render :index
  end

  def show
    @sub = Sub.find_by(id: params[:id])
    if @sub
      render :show
    else
      redirect_to subs_url
    end
  end

  def destroy
    @sub = Sub.find_by(id: params[:id])
    @sub.destroy
    redirect_to subs_url
  end

  private
  def sub_params
    params.require(:sub).permit(:title, :description, :moderator_id)
  end

  def check_user_id
    subreddit = Sub.find_by(id: params[:id])
    if subreddit.moderator_id != current_user.id
      redirect_to sub_url(subreddit)
    end
  end

end
