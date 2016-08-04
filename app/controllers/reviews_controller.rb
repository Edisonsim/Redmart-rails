class ReviewsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user, only: :destroy

  def new
    @product = Product.find(params[:product_id])
    @review = Review.new(product_id: params[:product_id])
    @feed_items = current_user.feed.paginate(page: params[:page])
  end

def show
  @review = current_user.reviews.build
  @feed_items = current_user.feed.paginate(page: params[:page])
end

  def create
    # p review_params
    @review = current_user.reviews.build(content: review_params[:content], product_id: review_params[:product_id], user_id: current_user.id)
    if @review.save
      # p 'review was saved'
      flash[:success] = "Review created!"
      @product = Product.find(review_params[:product_id])
      redirect_to @product
    end
  end

  def destroy
    @review.destroy
    flash[:success] = "Review deleted"
    redirect_to request.referrer || root_url
  end

  private



    def review_params
      params.require(:review).permit(:content, :product_id)
    end

    def correct_user
      @review = current_user.reviews.find_by(id: params[:id])
      redirect_to root_url if @review.nil?
    end
end
