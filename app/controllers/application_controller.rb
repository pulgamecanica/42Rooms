class ApplicationController < ActionController::Base
	before_action :set_finished
	# before_action :set_time

  private
	  def set_finished
	    Reservation.where(finished: false).each do |r|
	      if (r.starts_at < DateTime.now && r.ends_at < DateTime.now)
	        r.update(finished: true)
	        if not r.save
	          puts r.errors.full_messages
	        end
	      end
	    end
	  end

	  def set_time
	  	@time  = Time.now.strftime("%H:%M:%S ")
	  end
end
