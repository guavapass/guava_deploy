class HomeController < ApplicationController
  def index
    time_now = Time.zone.now

    @todays_visits = Visit.where(created_at: time_now.beginning_of_day .. time_now).order(start_at: :desc)

    yesterday = time_now - 1.day
    @yesterday_visits = Visit.where(created_at: yesterday.beginning_of_day .. yesterday.end_of_day).order(start_at: :desc)

    @icon_color = CurrentState.color

    @yesterday_visits_by_hour = visits_by_hour(@yesterday_visits)

    @total_time = yesterday_total_time(@yesterday_visits)
  end

  private

  def visits_by_hour(visits)
    visits.group_by do |visit|
      visit.start_at.strftime('%l %P')
    end
  end

  def yesterday_total_time(visits)
    visits.map do |visit|
      next unless visit.end_at

      (visit.start_at - visit.end_at).to_i
    end.compact.inject(&:+)
  end
end
