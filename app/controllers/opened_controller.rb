class OpenedController < ApplicationController
  def create
    DoorEvent.create!(action: DoorEvent::OPENED)
  end
end
