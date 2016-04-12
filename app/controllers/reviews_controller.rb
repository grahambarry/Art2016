 class ReviewsController < ApplicationController
  before_action :logged_in_use, only: [:create, :destroy]
  before_action :correct_use,   only: :destroy
  before_action :set_review, only: [:show, :edit, :update, :destroy]
  before_action :set_pin



  # GET /reviews/new
  def new
    @review = Review.new
  end

  # GET /reviews/1/edit
  def edit
  end

  # POST /reviews
  # POST /reviews.json
  def create
    @review = Review.new(review_params)
    @review_cussy = Cussy.evaluate(@review.comment)
    @review.use_id = current_use.id
    @review.pin_id = @pin.id
    @review.comment = @review_cussy
    
    #@cussy = params[:comment]


  
      if @review.save
        redirect_to @pin, remote: true, notice: 'Your Review Has Been Added, Thank You.'
        
      else
        render :new
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end


  # PATCH/PUT /reviews/1
  # PATCH/PUT /reviews/1.json
  def update
    @review = Review.PATCH(review_params)
    @review.use_id = current_use.id
    @review.pin_id = @pin.id
    respond_to do |format|
      if @review.update(review_params)
        format.html { redirect_to @pin, notice: 'Review was successfully updated.' }
        format.json { render :show, status: :ok, location: @review }
      else
        format.html { render :edit }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reviews/1
  # DELETE /reviews/1.json
  def destroy
    @review.destroy
    respond_to do |format|
      format.html { redirect_to reviews_url, notice: 'Review was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_review
      @review = Review.find(params[:id])
    end

      def set_pin
      @pin = Pin.find(params[:pin_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def review_params
      params.require(:review).permit(:rating, :comment)
    end
end
