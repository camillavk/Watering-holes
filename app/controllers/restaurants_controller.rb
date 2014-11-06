class RestaurantsController < ApplicationController

  before_action :authenticate_user!, :except => [:index, :show]

  def index
    @restaurants = Restaurant.all
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.new(params.require(:restaurant).permit(:name, :image))
    @restaurant.user_id = current_user.id
    if @restaurant.save
      flash[:notice] = 'Restaurant created successfully'
      # redirect_to '/'
    else @restaurant.delete
      flash[:notice] = 'Error: Name is too short'
    end
      redirect_to '/'
  end

  def show
    @restaurant = Restaurant.find(params[:id])
  end

  def edit
    @restaurant = current_user.restaurants.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash[:notice] = 'Not your restaurant'
    redirect_to '/'
  end

  def update
    @restaurant = Restaurant.find(params[:id])
    @restaurant.update(params.require(:restaurant).permit(:name, :image))
    redirect_to '/'
  end

  def destroy
    @restaurant = current_user.restaurants.find(params[:id])
    # if current_user.id == @restaurant.user_id
      @restaurant.destroy
      flash[:notice] = 'Restaurant deleted successfully'
    # redirect_to '/', notice: 'Not your restaurant' unless current_user.id == @restaurant.user_id
    redirect_to '/'
  end

end
