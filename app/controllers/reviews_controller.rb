class ReviewsController < ApplicationController

  before_action :authenticate_user!

  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = Review.new
  end

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = @restaurant.reviews.new(params[:review].permit(:thoughts, :rating))
    @review.user = current_user
    if @review.save
      redirect_to '/'
    else
      render 'new'
    end
  end

  def destroy
    @review = Review.find(params[:id])

    if current_user == @review.user
      @review.destroy
      flash[:notice] = 'Review deleted successfully'
    else
      flash[:notice] = 'Not your review'
    end
    redirect_to '/'
  end


end
