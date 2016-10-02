class HomeController < ApplicationController
  def index
    time_now = Time.zone.now
    yesterday = time_now - 1.day

    @todays_visits = Visit.where(start_at: time_now.beginning_of_day .. time_now).order(start_at: :desc)

    # Last used that was not today
    @last_used_at = Visit.where('start_at < ?', yesterday.end_of_day).last.start_at

    last_used_day_visits = Visit.where(
      start_at: @last_used_at.beginning_of_day .. @last_used_at.end_of_day
    ).order(start_at: :asc)

    @icon_color = CurrentState.color

    set_stats(last_used_day_visits)
  end

  private

  def set_stats(visits)
    @last_used_day_visits_by_hour = visits_by_hour(visits)

    @last_used_day_total_time = visits_total_time(visits)

    @last_used_day_visits = visits_duration_sorted(visits)
  end

  def visits_duration_sorted(visits)
    visits.sort_by do |visit|
      next unless visit.end_at

      (visit.end_at - visit.start_at).to_i
    end
  end

  def visits_by_hour(visits)
    visits.group_by do |visit|
      visit.start_at.strftime('%l %P')
    end
  end

  def visits_total_time(visits)
    visits.map do |visit|
      next unless visit.end_at

      (visit.end_at - visit.start_at).to_i
    end.compact.inject(&:+)
  end
end
