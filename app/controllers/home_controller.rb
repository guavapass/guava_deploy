class HomeController < ApplicationController
  def index
    time_now = Time.zone.now
    @events = []

    raw_events = DoorEvent.where(created_at: time_now.beginning_of_day .. time_now).order(created_at: :desc)

    raw_events.each_cons(2) do |event, next_event|
      @events << event if event.action != next_event&.action
    end

    @latest_event = DoorEvent.last

    @icon_color = @latest_event.current_color

    @yesterday_closes = yesterday_closes
    @yesterday_closes_by_hour = closes_by_hour(@yesterday_closes)

    @total_time = yesterday_total_time(@yesterday_closes)
  end

  private

  def yesterday_closes
    yesterday = Time.zone.now - 1.day
    yesterday_start = yesterday.beginning_of_day
    yesterday_end = yesterday.end_of_day

    DoorEvent.where(
      action: 0, created_at: yesterday_start .. yesterday_end
    )
  end

  def closes_by_hour(closes)
    closes.group_by do |event|
      event.created_at.strftime('%l %P')
    end
  end

  def yesterday_total_time(closes)
    closes.map do |close|
      open = DoorEvent.find(close.id + 1)

      next unless open

      (open.created_at - close.created_at).to_i
    end.inject(&:+)
  end
end
