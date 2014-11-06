module ReviewsHelper

  def star_rating(rating)
    return rating unless rating.respond_to?(:round)
    remainder = (5 - rating)
    "★" * rating.round + "☆" * remainder
  end

  def add_review(restaurant)
    if can?(:create, Review) && restaurant.not_reviewed_by?(current_user)
    link_to "Review", new_restaurant_review_path(restaurant)
  end
  end


end
