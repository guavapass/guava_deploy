class ClosedController < ApplicationController
  def create
    DoorEvent.create!(action: DoorEvent::CLOSED)
  end
end
