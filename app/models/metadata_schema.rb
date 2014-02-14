class MetadataSchema < ActiveRecord::Base
	has_ancestry

	has_many :lo_metadata_schemas
	has_many :learning_objects, :through => :lo_metadata_schemas

	attr_accessible :name, :parent_id

	#Obtengo los metadatos generales
	def self.general
		where("name like ?", "%eneral%").first.descendants
	end

	#Obtengo los metadatos de ciclo de vida
	def self.life_cycle
		where("name like ?", "%ycle%").first.descendants		
	end

	#Obtengo los metadatos educacionales
	def self.educational
		where("name like ?", "%ducational%").first.descendants
	end

	#Obtengo los metadatos de derechos
	def self.rights
		where("name ilike ?", "%rights%").first.descendants
	end

	# Guardo los metadatos generales del objeto de aprendizaje que estoy leyendo
	def self.general_identifier(learning_object, identifier)
		gi = general.where("name like ?", "%dentifier%").first.id
		LoMetadataSchema.create(:metadata_schema_id => gi, :learning_object_id => learning_object.id, :value => identifier)
	end

	def self.general_title(learning_object, title)
		gt = general.where("name like ?", "%itle%").first.id
		LoMetadataSchema.create(:metadata_schema_id => gt, :learning_object_id => learning_object.id, :value => title)
	end

	def self.general_language(learning_object, array_languages)
		gl = general.where("name like ?", "%anguag%").first.id
		array_languages.each do |language|
			LoMetadataSchema.create(:metadata_schema_id => gl, :learning_object_id => learning_object.id, :value => language)
		end		
	end

	def self.general_description(learning_object, description)
		gd = general.where("name like ?", "%escriptio%").first.id
		LoMetadataSchema.create(:metadata_schema_id => gd, :learning_object_id => learning_object.id, :value => description)
	end

	def self.general_keyword(learning_object, array_keywords)
		gk = general.where("name like ?", "%eyword%").first.id
		array_keywords.each do |keyword|
			LoMetadataSchema.create(:metadata_schema_id => gk, :learning_object_id => learning_object.id, :value => keyword)	
		end
	end

	def self.general_coverage(learning_object, coverage)
		gc = general.where("name like ?", "%overag%").first.id
		LoMetadataSchema.create(:metadata_schema_id => gc, :learning_object_id => learning_object.id, :value => coverage)
	end

	def self.general_structure(learning_object, structure)
		ge = general.where("name like ?", "%tructure%").first.id
		LoMetadataSchema.create(:metadata_schema_id => ge, :learning_object_id => learning_object.id, :value => structure)
	end

	def self.general_aggregation_level(learning_object, aggregation_level)
		gal = general.where("name like ?", "%ggregation%").first.id
		LoMetadataSchema.create(:metadata_schema_id => gal, :learning_object_id => learning_object.id, :value => aggregation_level)
	end

	# Guardo los metadatos del ciclo de vida del objeto de aprendizaje que estoy leyendo
	def self.life_cycle_version(learning_object, version)
		lcv = life_cycle.where("name like ?", "%ersion%").first.id
		LoMetadataSchema.create(:metadata_schema_id => lcv, :learning_object_id => learning_object.id, :value => version)
	end

	def self.life_cycle_status(learning_object, status)
		lcs = life_cycle.where("name like ?", "%tatus%").first.id
		LoMetadataSchema.create(:metadata_schema_id => lcs, :learning_object_id => learning_object.id, :value => status)		
	end

	def self.life_cycle_contribute_role(learning_object, contribute_role)
		lccr = life_cycle.where("name like ?", "%ole%").first.id
		LoMetadataSchema.create(:metadata_schema_id => lccr, :learning_object_id => learning_object.id, :value => contribute_role)		
	end

	def self.life_cycle_contribute_entity(learning_object, contribute_entity)
		lcce = life_cycle.where("name like ?", "%ntity%").first.id
		LoMetadataSchema.create(:metadata_schema_id => lcce, :learning_object_id => learning_object.id, :value => contribute_entity)
	end

	def self.life_cycle_contribute_date(learning_object, contribute_date)
		lccd = life_cycle.where("name like ?", "%ate%").first.id
		LoMetadataSchema.create(:metadata_schema_id => lccd, :learning_object_id => learning_object.id, :value => contribute_date)
	end

	# Guardo los metadatos educacionales del objeto de aprendizaje que estoy leyendo
	def self.educational_interactivity_type(learning_object, interactivity_type)
		eit = educational.where("name ilike ?", "%nteractivity type%").first.id
		LoMetadataSchema.create(:metadata_schema_id => eit, :learning_object_id => learning_object.id, :value => interactivity_type)
	end

	def self.educational_learning_resource_type(learning_object, learning_resource_types)
		elrt = educational.where("name ilike ?", "%esource type%").first.id

		learning_resource_types.each do |lrt|
			LoMetadataSchema.create(:metadata_schema_id => elrt, :learning_object_id => learning_object.id, :value => lrt)				
		end
	end

	def self.educational_interactivity_level(learning_object, interactivitylevel)
		eil = educational.where("name ilike ?", "%nteractivity level%").first.id
		LoMetadataSchema.create(:metadata_schema_id => eil, :learning_object_id => learning_object.id, :value => interactivitylevel)
	end

	def self.educational_semantic_density(learning_object, semanticdensity)
		esd = educational.where("name ilike ?", "%ensity%").first.id
		LoMetadataSchema.create(:metadata_schema_id => esd, :learning_object_id => learning_object.id, :value => semanticdensity)
	end

	def self.educational_intended_end_user_role(learning_object, intendedenduserrole)
		eieur = educational.where("name ilike ?", "%user role%").first.id
		LoMetadataSchema.create(:metadata_schema_id => eieur, :learning_object_id => learning_object.id, :value => intendedenduserrole)
	end

	def self.educational_context(learning_object, context)
		ec = educational.where("name ilike ?", "%context%").first.id
		LoMetadataSchema.create(:metadata_schema_id => ec, :learning_object_id => learning_object.id, :value => context)
	end

	def self.educational_typical_age_range(learning_object, typicalagerange)
		etar = educational.where("name ilike ?", "%age range%").first.id
		LoMetadataSchema.create(:metadata_schema_id => etar, :learning_object_id => learning_object.id, :value => typicalagerange)
	end

	def self.educational_difficulty(learning_object, difficulty)
		ed = educational.where("name ilike ?", "%ifficulty%").first.id
		LoMetadataSchema.create(:metadata_schema_id => ed, :learning_object_id => learning_object.id, :value => difficulty)
	end

	def self.educational_typical_learning_time(learning_object, typicallearningtime)
		etlt = educational.where("name ilike ?", "%learning time%").first.id
		LoMetadataSchema.create(:metadata_schema_id => etlt, :learning_object_id => learning_object.id, :value => typicallearningtime)
	end

	def self.educational_description(learning_object, description)
		edes = educational.where("name ilike ?", "%description%").first.id
		LoMetadataSchema.create(:metadata_schema_id => edes, :learning_object_id => learning_object.id, :value => description)
	end

	def self.educational_language(learning_object, language)
		el = educational.where("name ilike ?", "%language%").first.id
		LoMetadataSchema.create(:metadata_schema_id => el, :learning_object_id => learning_object.id, :value => language)
	end

	# Guardo los metadatos de derechos del objeto de aprendizaje que estoy leyendo
	def self.rights_cost(learning_object, cost)
		rc = rights.where("name ilike ?", "%cost%").first.id
		LoMetadataSchema.create(:metadata_schema_id => rc, :learning_object_id => learning_object.id, :value => cost)
	end

	def self.rights_copy_right_and_other_restrictions(learning_object, copyrightandotherrestrictions)
		rcr = rights.where("name ilike ?", "%restriction%").first.id
		LoMetadataSchema.create(:metadata_schema_id => rcr, :learning_object_id => learning_object.id, :value => copyrightandotherrestrictions)
	end

	def self.rights_description(learning_object, description)
		rdes = rights.where("name ilike ?", "%description%").first.id
		LoMetadataSchema.create(:metadata_schema_id => rdes, :learning_object_id => learning_object.id, :value => description)
	end

	def self.find_description(learning_object)
		gd = general.where("name like ?", "%escriptio%").first.id
		LoMetadataSchema.where(:metadata_schema_id => gd, :learning_object_id => learning_object.id).first.value
	end

	def self.find_author(learning_object)
		lccr = life_cycle.where("name like ?", "%ole%").first.id
		LoMetadataSchema.where(:metadata_schema_id => lccr, :learning_object_id => learning_object.id).first.value
	end

	def self.find_keywords(learning_object)
		gk = general.where("name like ?", "%eyword%").first.id
		array_keywords = []
		keywords = LoMetadataSchema.where(:metadata_schema_id => gk, :learning_object_id => learning_object.id)

		keywords.each do |key|
			array_keywords << key.value
		end

		array_keywords.join(",")

	end
end
