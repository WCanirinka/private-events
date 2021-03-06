# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Attendance, type: :model do
  before :each do
    @user = User.create(email: 'foobar@example.com', name: 'foobar')
    @event = @user.events.create(date: '2020/12/12')
    @attendance = @user.attend(@event)
  end

  context 'with valid user id' do
    it 'should create an event' do
      expect(@event).to be_valid
    end
  end
end
