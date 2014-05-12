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
	$("#organization_title").tooltip
		placement: 'top'
		trigger: 'focus'
		title: 'Título de la organización de contenidos'

	$("#general_title").tooltip
		placement: 'top'
		trigger: 'focus'
		title: 'Título del OA'

	$("#general_identifier").tooltip
		placement: 'top'
		trigger: 'focus'
		title: 'Valor que identifica este OA'

	$("#general_languages").tooltip
		placement: 'top'
		trigger: 'focus'
		title: 'Lenguaje de este OA (es, en)'

	$("#general_coverage").tooltip
		placement: 'top'
		trigger: 'focus'
		title: 'Describe el alcance del OA. Por ejemplo, tecnologías de la información'

	$("#general_structure").tooltip
		placement: 'top'
		trigger: 'focus'
		title: 'Describe la estructura organizacional del contenido (Atomic, Branched, Collection, Hierarchical, Linear, Mixed, Networked, Parceled)'

	$("#general_aggregation_level").tooltip
		placement: 'top'
		trigger: 'focus'
		title: 'Granularidad funcional del OA (1 = nivel más bajo de granularidad [recurso básico], 4 = más alto nivel de granularidad [curso completo])'

	$("#input-keywords").tooltip
		placement: 'top'
		trigger: 'focus'
		title: 'Separadas por comas'

	$("#life_cycle_version").tooltip
		placement: 'top'
		trigger: 'focus'
		title: 'Versión actual del OA'

	$("#life_cycle_status").tooltip
		placement: 'top'
		trigger: 'focus'
		title: 'Estado actual del OA (Draft, Final, Revised, Unavailable)'

	$("#life_cycle_contribute_role").tooltip
		placement: 'top'
		trigger: 'focus'
		title: 'Nombre del autor del OA'

	$("#life_cycle_contribute_entity").tooltip
		placement: 'top'
		trigger: 'focus'
		title: 'Nombre de la entidad o persona que realiza la contribución'

	$("#life_cycle_contribute_date").tooltip
		placement: 'bottom'
		trigger: 'focus'
		title: 'Fecha de la contribución'

	$("#educational_interactivity_type").tooltip
		placement: 'top'
		trigger: 'focus'
		title: 'Describe el tipo dominante de aprendizaje llevado a cabo en este OA (Active, Expositive, Mixed, Undefined).'

	$("#educational_learning_resource_types").tooltip
		placement: 'top'
		trigger: 'focus'
		title: 'Describe el tipo de recursos en este OA (ejercicios, simulaciones, cuestionarios, diagrama, figura, gráfico, índice, presentación, tabla, texto narrativo, examen, experimento, planteamiento del problema, la autoevaluación, conferencia, etc).'

	$("#educational_interactivity_level").tooltip
		placement: 'top'
		trigger: 'focus'
		title: 'Describe el grado en el que el alumno puede afectar a la experiencia de aprendizaje (Very Low, Low, Medium, High, Very High).'

	$("#educational_semantic_density").tooltip
		placement: 'top'
		trigger: 'focus'
		title: 'Describe el grado de concisión de los contenidos en el OA (Very Low, Low, Medium, High, Very High).'

	$("#educational_intended_end_user_role").tooltip
		placement: 'top'
		trigger: 'focus'
		title: 'Describe al principal usuario para el que el OA fue diseñado (Teacher, Author, Learner, Manager).'

	$("#educational_context").tooltip
		placement: 'top'
		trigger: 'focus'
		title: 'Describe el entorno en el que el OA está destinado a ser entregado (Higher Education, Primary Education, Professional Formation, University Postgrade, etc).'

	$("#educational_typical_age_range").tooltip
		placement: 'top'
		trigger: 'focus'
		title: 'Describe la edad del usuario del OA ("edad mínima - edad máxima", en años, p.e: "20-30")'

	$("#educational_difficulty").tooltip
		placement: 'top'
		trigger: 'focus'
		title: 'Describe lo difícil que es para un estudiante trabajar a través de este OA, asumiendo que el alumno está en el contexto previsto y en el rango de edad previsto (Very easy, Easy, Medium, Difficult, Very difficult).'

	$("#educational_typical_learning_time").tooltip
		placement: 'top'
		trigger: 'focus'
		title: 'Cantidad esperada de tiempo que tomará para que el interesado complete este OA, asumiendo que está en el contexto previsto y en el rango de edad previsto (en minutos).'

	$("#educational_description").tooltip
		placement: 'top'
		trigger: 'focus'
		title: 'Describe cómo este OA debe ser usado'

	$("#educational_language").tooltip
		placement: 'top'
		trigger: 'focus'
		title: 'Representa el lenguaje utilizado por el alumno (es, en).'

	$("#rights_cost").tooltip
		placement: 'top'
		trigger: 'focus'
		title: '¿Existe un costo financiero asociado con el uso de este OA?'

	$("#rights_copy_rights_and_other_restrictions").tooltip
		placement: 'top'
		trigger: 'focus'
		title: '¿Este OA es con derechos de autor o tiene otras restricciones de uso?'

	$("#input-rightsdescription").tooltip
		placement: 'top'
		trigger: 'focus'
		title: 'Una descripción textual sobre el uso permitido del OA.'

	# El hover en el rating de un OA
	$(".hover-star").rating
		focus: (value, link) ->
			tip = $("#hover-test")
			tip[0].data = tip[0].data or tip.html()
			tip.html link.title or "value: " + value
		blur: (value, link) ->
			tip = $("#hover-test")
			$("#hover-test").html tip[0].data or ""

	# El cambio en las categorias en la busqueda de OA en vista principal
	$('#search_by').change ->
		search_by = $('#search_by :selected').val()
		if search_by == "3" #por categoria
			document.getElementById("query_text_field_index").style.display = "none"
			document.getElementById("category_value_index").style.display = "inline"
			#$('#query_text_field').toggle()
			#$('#category_value').toggle()			
		else
			document.getElementById("category_value_index").style.display = "none"
			document.getElementById("query_text_field_index").style.display = "inline"
			#$('#category_value').hide()			
			#$('#query_text_field').show()

	# El cambio en las categorias en la busqueda de OA en vista de administrador
	$('#select_search_admin').change ->
		search_by = $('#select_search_admin :selected').val()
		if search_by == "3" #por categoria
			document.getElementById("query_text_field_admin").style.display = "none"
			document.getElementById("category_value_admin").style.display = "inline"
			#$('#query_text_field').toggle()
			#$('#category_value').toggle()			
		else
			document.getElementById("category_value_admin").style.display = "none"
			document.getElementById("query_text_field_admin").style.display = "inline"
			#$('#category_value').hide()			
			#$('#query_text_field').show()
				
			
	
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