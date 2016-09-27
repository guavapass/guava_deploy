class HomeController < ApplicationController
  def index
    @events = DoorEvent.order(created_at: :desc).limit(20)
  end
end
