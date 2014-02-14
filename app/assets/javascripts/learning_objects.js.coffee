# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
	#$("#learning_object_course_id").chosen()
	$("input:file").on "change", ->
		$("input:submit").prop "disabled", not $(this).val()

	# Muestra el combobox de cursos y topicos cuando estoy subiendo un nuevo material
	$(".learning_object_content_id").parent().hide()
	topics = $('.learning_object_content_id').html()
	# console.log(topics)
	$('.learning_object_course_id').change ->
		course = $('.learning_object_course_id :selected').text()
		options = $(topics).filter("optgroup[label='#{course}']").html()
		if options
			$(".learning_object_content_id").html(options)
			$(".learning_object_content_id").parent().show()
			#$("#learning_object_content_id").chosen()
		else
			$(".learning_object_content_id").empty()
			$(".learning_object_content_id").parent().hide()

	$(".learning_content_id").parent().hide()
	topics = $('.learning_content_id').html()
	# console.log(topics)
	$('.learning_course_id').change ->
		course = $('.learning_course_id :selected').text()
		options = $(topics).filter("optgroup[label='#{course}']").html()
		if options
			$(".learning_content_id").html(options)
			$(".learning_content_id").parent().show()
			#$("#learning_object_content_id").chosen()
		else
			$(".learning_content_id").empty()
			$(".learning_content_id").parent().hide()
	
	$(".hover-star").rating
		focus: (value, link) ->
			tip = $("#hover-test")
			tip[0].data = tip[0].data or tip.html()
			tip.html link.title or "value: " + value
		blur: (value, link) ->
			tip = $("#hover-test")
			$("#hover-test").html tip[0].data or ""

	# $('#select_search_by').click ->
	# 	$('#simply_search').toggle()
	# 	$('#search_by_category').toggle()
	$('#select_search_by').change ->
		search_by = $('#select_search_by :selected').val()
		if search_by == "3" #por categoria
			$('#query_text_field').toggle()
			$('#category_value').toggle()
		else			
			$('#category_value').hide()
			$('#query_text_field').show()
			