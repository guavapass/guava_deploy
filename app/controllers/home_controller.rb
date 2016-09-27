class HomeController < ApplicationController
  def index
    @events = []

    DoorEvent.order(created_at: :desc).limit(100).each_cons(2) do |event, next_event|
      @events << event if event.action != next_event&.action
    end

    @last_event = DoorEvent.last
  end
end
