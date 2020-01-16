# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: %i[show update edit destroy]
  before_action :logged_in?, only: %i[new create edit update destroy index]

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    @events = @user.events
    @attendances = @user.attendances
    @past_events = Event.past
    @upcoming_events = Event.upcoming
    @logged_in = logged_in?
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

  def edit
    # code
  end

  def update
    @user.update(user_params)
    if @user.save
      flash[:success] = "Congrats #{@user.name}!, you've successfully updated your profile!"
      redirect_to @user
    else
      render :edit
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

  def set_user
    @user = User.find(params[:id])
  end
end
