class DoorEvent::ClosedController < ApplicationController
  def create
    event = DoorEvent.create!(action: DoorEvent::CLOSED)

    render json: event.to_json
  end
end
