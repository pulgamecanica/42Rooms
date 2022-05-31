// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "jquery"
import "jquery_ujs"
import "chartkick"
import "Chart.bundle"


 $(document).ready(function () {
    if ($('#time-container').length) {
    	setInterval(function () {
    	$('#time-container').load('/clock/get_time');
    	}, 1000);
	}
});