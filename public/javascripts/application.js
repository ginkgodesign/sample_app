// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

Event.observe(window, 'load', function(e) {
	var textarea 	= $('micropost_content');		// Textarea id
	var countdown = $('countdown');  					// Countdown id
	var maxChars  = 140;
	updateCountdown(textarea, countdown, maxChars);
	textarea.observe('keyup', function(event) {
		updateCountdown(this, countdown, maxChars);
	});
});

function updateCountdown(textarea, countdown, maxChars) {
	var charsLeft = maxChars - textarea.value.length;
	if (charsLeft >= 0 && charsLeft != 1) {
		countdown.update(charsLeft + ' characters left');
		countdown.removeClassName('long');
	} else if (charsLeft == 1) {
		countdown.update(charsLeft + ' character left');
		countdown.removeClassName('long');
	} else {
		countdown.update('Your micropost is too long!');
		countdown.addClassName('long');
	}
}