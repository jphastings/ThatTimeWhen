jQuery(document).ready(function() {
	jQuery("time").timeago();

	$('#add').click(function(e) {
		e.preventDefault();
		$('#new').css({'position':'absolute','top':'0'})
		$('#story .told').fadeOut()
		$('#new').fadeIn(function() {
			$('#new').css({'position':'relative','top':null})
		})
	})
});