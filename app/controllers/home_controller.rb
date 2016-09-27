class HomeController < ApplicationController
  def index
    prev_event = nil

    @events = DoorEvent.order(created_at: :desc).limit(100).select do |event|
      if prev_event&.action != event.action
        prev_event = event
        true
      end
    end

    @last_event = DoorEvent.last
  end
end
