class MicropostsController < ApplicationController
  before_filter :authenticate,    :only => [:create, :destroy, :index]
  before_filter :authorised_user, :only => :destroy
  
  def create
    @micropost = current_user.microposts.build(params[:micropost])
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to root_path
    else
      @feed_items = []
      render 'pages/home'
    end
  end
  
  def destroy
    @micropost.destroy
    flash[:success] = "Micropost destroyed."
    redirect_back_or root_path
  end
  
  def index
    @user = User.find(params[:user_id])
    @microposts = @user.microposts.paginate(:page => params[:page])
    @title = @user.name + "'s Microposts"
  end
  
  private
  
    def authorised_user
      @micropost = Micropost.find(params[:id])
      redirect_to root_path unless current_user?(@micropost.user)
    end
  
end