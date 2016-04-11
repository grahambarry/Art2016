class UsesController < ApplicationController
  before_action :logged_in_use, only: [:index, :edit, :update]
    before_action :correct_use,   only: [:edit, :update, :destroy]
    before_action :admin_use,     only: [:destroy]

    #before_action :set_s3_direct_post, only: [:new, :edit, :create, :update]
    
def to_key
new_record? ? nil : [ self.send(self.class.primary_key) ]
end   

  def index
    @uses = Use.paginate(page: params[:page], per_page: 25).order("created_at DESC")

  @uses = Use.all

  
  if params[:search]
    @uses = Use.search(params[:search]).order("created_at DESC").paginate(page: params[:page], per_page: 25)
  
  else
    @uses = Use.paginate(page: params[:page], per_page: 25).order("created_at DESC")

  end
end

  def show
    @use = Use.find(params[:id])
     @microposts = current_use.microposts.build if logged_in?
    @microposts = @use.microposts.paginate(page: params[:page])
    
  end

  def new
  	@use = Use.new
respond_to do |format|
    format.js {render :content_type => 'text/javascript'}
end
  end

  def create
    @use = Use.new(use_params)
    if @use.save
      @use.send_activation_email
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
    else
      render 'new'
    end
  end

  def edit
    begin
    @use = Use.find(params[:id])
    rescue => error
flash[:info] = "Oops, something Went Wrong."
  end
end

    def update
    @use = Use.find(params[:id])
    if @use.update_attributes(use_params)
      # Handle a successful update.
            flash[:success] = "Profile updated"
      redirect_to @use
    else
      render 'edit'
    end
  end

    def destroy
    Use.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to uses_url
  end

  def login
    respond_to do |format|
    format.js {render :content_type => 'text/javascript'}
end
end

def admin_login
session[:login] = 1
session[:cart] = nil
flash[:notice] = "Admin Login Successful!!"
redirect_to :controller => :items
end

def logout
session[:login] = nil
session[:cart] = nil
flash[:notice] = "You have successfully logged out!!"
redirect_to :controller => :pins
end

  private

    def use_params
      params.require(:use).permit(:name, :email, :password, :password_confirmation)
    end

    # Confirms the correct user.
    def correct_use
      @use = Use.find(params[:id])
      redirect_to(root_url) unless current_use?(@use)
    end

    # Use callbacks to share common setup or constraints between actions.
    #def set_use
      #@use = Use.find(params[:id])
    #end

#def set_s3_direct_post
    #@s3_direct_post = S3_BUCKET.presigned_post(key: "uploads/#{SecureRandom.uuid}/${filename}", success_action_status: '201', acl: 'public-read')
  #end

    # Confirms an admin user.
    def admin_use
      redirect_to(root_url) unless current_use.admin?
    end

  end
