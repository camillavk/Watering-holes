module RestaurantsHelper

  # def edit_link(restaurant)
    # link_to "Edit #{restaurant.name}", edit_restaurant_path(restaurant) if can?(:update, restaurant)
  # end

  def edit_link(restaurant)
    link_to "Edit #{restaurant.name}", edit_restaurant_path(restaurant) if can?(:update, restaurant)
  end

  def delete_link(restaurant)
    link_to "Delete #{restaurant.name}", restaurant_path(restaurant), method: :delete if can?(:destroy, restaurant)
  end



end
