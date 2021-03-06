# frozen_string_literal: true

class EventsController < ApplicationController
  before_action :logged_in?, only: %i[create destroy]
  before_action :correct_user, only: :destroy

  def new
    @event = Event.new
  end

  def show
    @event = Event.find(params[:id])
    @logged_in = logged_in?
  end

  def index
    @events = Event.all
    @logged_in = logged_in?
    @past_events = Event.past
    @upcoming_events = Event.upcoming
  end

  def create
    @event = current_user.events.build(event_params)
    @event.user_id = current_user.id
    if @event.save
      flash[:success] = 'Event created!'
      redirect_to root_url
    else
      @feed_items = []
      render 'new'
    end
  end

  def update
    @event.update(event_params)
    if @event.save
      flash[:success] = 'Event was successfully updated!'
      redirect_to @event
    else
      render :edit
    end
  end

  def destroy; end

  private

  def event_params
    params.require(:event).permit(:date)
  end

  def correct_user
    @event = current_user.events.find_by(id: params[:id])
    redirect_to root_url if @event.nil?
  end

  def set_event
    @event = Event.find(params[:id])
  end
end
