class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: :show
  before_action :set_user, only: %i[show edit update]

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render :show, status: :unproccessable_entity
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
    authorize @user
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :bio, :specialty, :photo, :nickname)
  end
end
