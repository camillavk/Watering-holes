class EndorsementsController < ApplicationController

  def create
    @review = Review.find(params[:review_id])
    @review.endorsements.create
    # p @review.endorsements.count
    render json: {new_endorsement_count: @review.endorsements.count}
  end

end
