class PostsController < ApplicationController
  
  before_action :fetch_user, only: [:create, :destroy]
  before_action :correct_user, only: [:destroy]

  # def index
  #   @posts = Post.all
  # end

  # def show
  #   @post = Post.find(params[:id])
  # end
  

  # def new
  #   @post = Post.new
  # end
   
  def create
    @post = @current_user.posts.build(post_params)
   
    if @post.save
      flash[:success] = "New post created!"
      redirect_to root_url
    else
      @feed_items = []
      render 'pages/home'
    end
  end

  # def edit
  #   @post = Post.find(params[:id])
  # end

  # def update
  #   post = Post.find(params[:id])
   
  #   if post.update(post_params)
  #     redirect_to post
  #   else
  #     render 'edit'
  #   end
  # end

  def destroy
    # @post = Post.find params[:id]
    @post.destroy 
    flash[:success] = "Post deleted"
    redirect_to request.referrer || root_url
    end
   
  private
    def post_params
      params.require(:post).permit(:title, :content)
    end

    def correct_user
      @post = @current_user.posts.find_by(id: params[:id])
      redirect_to root_url if @post.nil?
    end
end
