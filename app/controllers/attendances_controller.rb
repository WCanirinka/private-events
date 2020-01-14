class AttendancesController < ApplicationController
  def create
    event = Event.find(params[:event_id])
    current_user.attend(event)
    redirect_back_or_to event
  end

  def destroy
    event = Attendance.find(params[:id]).event
    current_user.unattend(event)
    redirect_back_or_to event
  end
end
