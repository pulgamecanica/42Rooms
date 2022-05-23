module ApplicationHelper
	def get_middle(enum, len, mid)
    return enum unless len < enum.count
    if len % 2 == 0
      first = mid - (len / 2) + 1
    else
      first = mid - (len / 2)
    end
    last = mid + (len / 2)
    if (first <= 0)
    	last += first.abs + 1
    elsif (last > enum.count)
      first += enum.count - last
    end
    enum.select {|n| n >= first && n <= last}
	end
end
