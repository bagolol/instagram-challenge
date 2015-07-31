class CommentsController < ApplicationController

  before_action :authenticate_user!, except: [:index, :show]

  def new
    @picture = Picture.find(params[:picture_id])
    @comment = Comment.new
  end

  def create
    @picture = Picture.find(params[:picture_id])
    @picture.comments.create(review_params)
    redirect_to pictures_path
  end

  def review_params
    params.require(:comment).permit(:comment)
  end

end
