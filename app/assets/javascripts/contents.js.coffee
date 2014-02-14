# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
	$( '#accordion' ).accordion
	    collapsible: true
	    heightStyle: "content"
	    icons:
	      header: "ui-icon-arrowthick-1-e"
	      activeHeader: "ui-icon-arrowthick-1-s"
	      
	$("#material-button").click ->
		$('#material-toggle').toggle()