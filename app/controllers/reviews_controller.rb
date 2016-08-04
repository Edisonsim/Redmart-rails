class ReviewsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user, only: :destroy

  def new
    @review = Review.new
    @feed_items = current_user.feed.paginate(page: params[:page])

  end
def show

  @review = current_user.reviews.build
  @feed_items = current_user.feed.paginate(page: params[:page])
end
  def create
    @review = current_user.reviews.build(review_params)
    if @review.save
      flash[:success] = "Review created!"
      redirect_to '/reviews'
    else
       @feed_items = []
      render 'reviews/new'
    end
  end

  def destroy
    @review.destroy
    flash[:success] = "Review deleted"
    redirect_to request.referrer || root_url
  end

  private

    def review_params
      params.require(:review).permit(:content, :picture)
    end

    def correct_user
      @review = current_user.reviews.find_by(id: params[:id])
      redirect_to root_url if @review.nil?
    end
end
