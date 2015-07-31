class LikesController < ApplicationController

  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!, except: [:index, :show]

  def create
    @picture = Picture.find(params[:picture_id])
    @picture.likes.create(user_id: current_user)
    redirect_to pictures_path
  end

end
