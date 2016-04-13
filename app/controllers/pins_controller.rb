class PinsController < ApplicationController
		before_action :find_pin, only: [:show, :edit, :delete, :update, :upvote, :downvote]
skip_before_action :verify_authenticity_token
  def search
    if params[:search].present?
      @pins = Pin.search(params[:search])
    else
      @pins = Pin.all
    end
  end

  
  def index
    @pins = Pin.paginate(page: params[:page], per_page: 12).order("created_at DESC")
	    respond_to do |format|
	    format.html
	    format.js # add this line for your js template

  if params[:search]
    @pins = Pin.search(params[:search]).order("created_at DESC").paginate(page: params[:page], per_page: 9)

  else
    @pins = Pin.paginate(page: params[:page], per_page: 9).order("created_at DESC")
    @microposts = current_use.microposts.build if logged_in?
  end
end
		@pins = Pin.all
   
    @pin = Pin.new

    	@microposts = current_use.microposts.build if logged_in?


end







  def home
    @pins = Pin.where(:use_id => current_use.id).paginate(:page => params[:page])
    @reviews = current_use.reviews.build if logged_in?
    if signed_in?
      @micropost  = current_use.microposts.build
      @feed_items = current_use.feed.paginate(page: params[:page])
  end
end







  

	def show
		@pins = Pin.all
		@picture_frames = PictureFrame.all
		@review = Review.new if logged_in?
    	@microposts = current_use.microposts.build if logged_in?
		@reviews = Review.where(pin_id: @pin.id).order("created_at DESC")
	if 	
			@reviews.blank?
      		@avg_review = 3
    else
      		@avg_review = @reviews.average(:rating).round(2)
    end
  end

	def dropzy
		@pins = Pin.all
		@pin = Pin.new
	end

  def delete

    @pin = Pin.find(params[:pin_id])

  end

  #def destroy
    #@pins = Pin.all
    #@pin = Pin.find(params[:id])
    #@pin.destroy

  #end

  	def destroy
  		@pin = Pin.find(params[:id])
		@pin.destroy
		if @pin.destroy
			redirect_to root_path, notice: "Done1"
		else
			redirect_to root_path, notice: "Please Try Again"
		end
	end


	#def new
	#	@pin = current_use.pins.build

	#end
  def new
    @pin = current_use.pins.new
  end
	#def create
		#@pin = current_use.pins.build(pin_params)
		#if @pin.save
			#redirect_to @pin, notice: "Art successfully created"
		#else
			#render 'new'
		#end
	#end



  #def create
    #@pin = current_use.pins.build(pin_params)
  #end
	#def create
		#@pins = Pin.all
		#@pin = current_use.pins.create(pin_params)


	#end

	  def create
    @pin = current_use.pins.new(pin_params)

    if @pin.save
      render json: { message: "success", fileID: @pin.id }, :status => 200
    else
      render json: { error: @pin.errors.full_messages.join(',')}, :status => 400
    end     
  end


	

	def edit

	end

	def update
		if @pin.update(pin_params)
			redirect_to @pin, notice: "Successfully updated"
		else
			render 'edit'
		end
	end



	def upvote
		if logged_in?
		@pin.upvote_by current_use
		redirect_to :back
else
		
		redirect_to (login_path)
end
		
	end

private

def pin_params
		params.require(:pin).permit(:title, :description, :image, :aspect, :image_meta, :price)
end
	

	def find_pin
		@pin = Pin.find(params[:id])
end

end


