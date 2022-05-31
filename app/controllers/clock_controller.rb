class ClockController < ApplicationController
  def get_time
    @time  = Time.now.strftime("%H:%M:%S ")
    render partial: "partials/date"
  end
end
