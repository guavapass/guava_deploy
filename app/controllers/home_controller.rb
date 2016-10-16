class HomeController < ApplicationController
  def index
    time_now = Time.zone.now

    @todays_visits = Visit.where(start_at: time_now.beginning_of_day .. time_now).order(start_at: :desc)

    @icon_color = CurrentState.color

    set_stats_alltime
    set_stats_lastused

    set_chat_user
    load_chat_all
  end

  private

  def load_chat_all
    @recent_chat = ChatMessage.order(created_at: :desc).limit(20)
  end

  def set_chat_user
    @nickname ||= ChatMessage::CHAT_NAMES.sample
  end

  def set_stats_alltime
    visits = Visit.where.not(end_at: nil).order(start_at: :asc)

    @alltime_visits_by_hour = visits_by_hour(visits)
    @alltime_total_time = visits_total_time(visits)
    @alltime_visits = visits_duration_sorted(visits)
  end

  def set_stats_lastused
    time_now = Time.zone.now
    yesterday = time_now - 1.day

    # Last used that was not today
    @last_used_at = Visit.where('start_at < ?', yesterday.end_of_day).last.start_at

    visits = Visit.where(
      start_at: @last_used_at.beginning_of_day .. @last_used_at.end_of_day
    ).where.not(
      end_at: nil
    ).order(start_at: :asc)

    @last_used_day_visits_by_hour = visits_by_hour(visits)
    @last_used_day_total_time = visits_total_time(visits)
    @last_used_day_visits = visits_duration_sorted(visits)
  end

  def visits_duration_sorted(visits)
    visits.sort_by do |visit|
      (visit.end_at - visit.start_at).to_i
    end
  end

  def visits_by_hour(visits)
    Hash[
      visits.group_by do |visit|
        visit.start_at.strftime('%l %P')
      end.sort do |a, b|
        DateTime.parse(a[0]) <=> DateTime.parse(b[0])
      end
    ]
  end

  def visits_total_time(visits)
    visits.map do |visit|
      (visit.end_at - visit.start_at).to_i
    end.compact.inject(&:+)
  end
end
