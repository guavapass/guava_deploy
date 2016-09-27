class DoorEvent::OpenedController < ApplicationController
  def create
    event = DoorEvent.create!(action: DoorEvent::OPENED)

    render json: event.to_json
  end
end
