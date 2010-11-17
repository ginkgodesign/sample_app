// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

Event.observe(window, 'load', function(e) {
	$('countdown').update('140 characters left');
	Event.observe('micropost_content', 'keyup', function(e) {
		var charsLeft = 140 - this.value.length;
		if (charsLeft >= 0 && charsLeft != 1) {
			$('countdown').update(charsLeft + ' characters left');
			$('countdown').removeClassName('long');
		} else if (charsLeft == 1) {
			$('countdown').update(charsLeft + ' character left');
			$('countdown').removeClassName('long');
		} else {
			$('countdown').update('Your micropost is too long!');
			$('countdown').addClassName('long');
		}
	});
});