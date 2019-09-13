class BlogsController < ApplicationController

  before_action :redirect_root, except: [:index, :show]

  def index
    @blogs = Blog.includes(:user).page(params[:page]).per(5).order("id DESC")
  end

  def show
    @blog = Blog.find(params[:id])
    @comments = @blog.comments.includes(:user)
  end

  def new
    @blog = Blog.new
  end

  def create
    Blog.create(image: blog_params[:image], text: blog_params[:text], user_id: current_user.id)
  end

  def edit
    @blog = Blog.find(params[:id])
  end

  def update
    blog = Blog.find(params[:id])
    if blog.user_id == current_user.id
      blog.update(blog_params)
    end
  end

  def destroy
    blog = Blog.find(params[:id])
    blog.destroy if blog.user_id == current_user.id
  end


  private
  def blog_params
    params.require(:blog).permit(:image, :text)
  end

  def redirect_root
    redirect_to root_path unless user_signed_in?
  end
end
