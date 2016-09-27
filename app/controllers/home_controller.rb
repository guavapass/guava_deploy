class HomeController < ApplicationController
  def index
    @events = []

    raw_events = DoorEvent.order(created_at: :desc).limit(100)

    raw_events.each_cons(2) do |event, next_event|
      @events << event if event.action != next_event&.action
    end

    @latest_event = raw_events.first

    @icon_color = @latest_event.current_color
  end
end
