class HomeController < ApplicationController
  def index
    @events = []

    raw_events = DoorEvent.order(created_at: :desc).limit(100)

    raw_events.each_cons(2) do |event, next_event|
      @events << event if event.action != next_event&.action
    end

    @latest_event = raw_events.first

    @icon_color = @latest_event.current_color

    yesterday = Time.zone.now - 1.day
    yesterday_start = yesterday.beginning_of_day
    yesterday_end = yesterday.end_of_day
    @yesterday = DoorEvent.where(
      action: 0, created_at: yesterday_start .. yesterday_end
    ).group_by do |event|
      event.created_at.strftime('%l %P')
    end
  end
end
