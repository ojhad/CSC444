class ReviewsController < ApplicationController
  before_action :find_user

  def index
  end

  def new
  end

  def create
    @review = Review.new(review_params)
    if @review.save
      redirect_to(user_path(@user.id))
    else
      render :new
    end
  end
  private

  def find_user
    if params[:user_id]
      @user = User.find(params[:user_id])
    end
  end

  def review_params
    params.require(:review).permit(:rating, :body, :user_id, :author_id)
  end

end
