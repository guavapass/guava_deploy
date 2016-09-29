class VisitsController < ApplicationController
  def index
    time_now = Time.zone.now

    @visits = Visit.order(start_at: :desc)
  end
end
