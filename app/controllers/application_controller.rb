class ApplicationController < ActionController::Base
	before_action :set_finished

  private
	  def set_finished
	    Reservation.all.each do |r|
	      if (r.starts_at < DateTime.now && r.ends_at < DateTime.now)
	        r.update(finished: true)
	        if not r.save
	          puts r.errors.full_messages
	        end
	      end
	    end
	  end
end
