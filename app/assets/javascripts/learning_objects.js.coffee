# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
	# Para levantar el calendario
	$( "#life_cycle_contribute_date" ).datepicker
		dateFormat: "dd/mm/yy"
		changeMonth: true
		changeYear: true
		showButtonPanel: true
	
	# Para validar que se sube un archivo
	$("input:file").on "change", ->
		$("input:submit").prop "disabled", not $(this).val()

	# Los hover en la explicacion de los metadatos al subir un OA
	$('#general_aggregation_level').tooltip
		placement: 'top'
		trigger: 'focus'
		title: 'hola'

	# El hover en el rating de un OA
	$(".hover-star").rating
		focus: (value, link) ->
			tip = $("#hover-test")
			tip[0].data = tip[0].data or tip.html()
			tip.html link.title or "value: " + value
		blur: (value, link) ->
			tip = $("#hover-test")
			$("#hover-test").html tip[0].data or ""

	# El cambio en las categorias en la busqueda de OA
	$('#search_by').change ->
		search_by = $('#search_by :selected').val()
		if search_by == "3" #por categoria
			$('#query_text_field').toggle()
			$('#category_value').toggle()
		else			
			$('#category_value').hide()
			$('#query_text_field').show()
				
			
	
	# Para elegir mas de una categoria (tema) en la subida de un OA
	$("#new_object_category_select").multiselect()
	$("#import_object_category_select").multiselect()

	# Para enviar un mensaje javascript cuando se desee editar un OA
	$("#edit_lo_link").click ->
		alert("Si modifica los metadatos de este objeto, el archivo 'imsmanifest.xml' quedará obsoleto. ¿Desea continuar?")

	# Tooltip cuando se busca por palabras clave
	# $('#search_by').change ->
	# 	search_by = $('#search_by :selected').val()
	# 	if search_by == "4" #por palabras clave
	# 		$('#query_text_field').tooltip
	# 			title: 'Separar por comas'
	# 			placement: 'top'