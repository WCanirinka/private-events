# frozen_string_literal: true

class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    @events = @user.events
  end

  def create
    @user = User.new(user_params)

    if @user.save
      log_in @user
      flash[:success] = 'Welcome!'
      redirect_to root_path
      # redirect_to user_url(@user)
    else
      render 'new'
    end
  end

  def upcoming
    @upcoming_events = current_user.attendings.upcoming
    render 'upcoming_events'
  end

  def past
    @past_events = current_user.attendings.past
    render 'past_events'
  end

  private

  def user_params
    params.require(:user).permit(:name, :email)
  end

end
