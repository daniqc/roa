module LearningObjectsHelper
	def nested_comments(comments, learning_object)
	  comments.map do |comment, sub_comments|
	    render(:partial => "comments/comment", :locals => {:comment => comment, :learning_object => learning_object}) + content_tag(:div, nested_comments(sub_comments, learning_object), :class => "row-fluid nested_comments")
	  end.join.html_safe
	end

	def rating_average(learning_object)
		rating_array = learning_object.ratings.map(&:evaluation)
		if !rating_array.empty?
			av_rating = rating_array.inject{ |sum, el| sum + el }.to_f / rating_array.size
			av_round = av_rating.round
			render :partial => "ratings/star_rating_average", :locals => {:av_rating => av_round, :learning_object => learning_object}
		else
			render :partial => "ratings/star_rating_average", :locals => {:av_rating => 0, :learning_object => learning_object}
		end		
	end

	# def nested_contents(contents, learning_object)
	# 	contents.map do |content, sub_contents|
	# 		render(:partial => "content", :locals => {:content => content}) + content_tag(:div, nested_contents(sub_contents, learning_object))
	# 	end.join.html_safe
	# end

	#--------------- GENERAL -------------------

	def obtain_general_title(learning_object, metadata_general)
		title = metadata_general.where("name like ?", "%itle%").first

		if title.nil?
    		title = MetadataSchema.general_title(learning_object, "")
    	else
    		title
    	end
	end

	def obtain_general_identifier(learning_object, metadata_general)
		id = metadata_general.where("name like ?", "%dentifier%").first

		if id.nil?
    		id = MetadataSchema.general_identifier(learning_object, "")
    	else
    		id
    	end
	end

	def obtain_general_languages(learning_object, metadata_general)
		lang = metadata_general.where("name like ?", "%anguage%").first

		if lang.nil?
    		lang = MetadataSchema.general_language(learning_object, "")
    	else
    		lang
    	end
	end

	def obtain_general_coverage(learning_object, metadata_general)
		cov = metadata_general.where("name like ?", "%overage%").first
		if cov.nil?
    		cov = MetadataSchema.general_coverage(learning_object, "")
    	else
    		cov
    	end
	end

	def obtain_general_structure(learning_object, metadata_general)
		str = metadata_general.where("name like ?", "%tructure%").first
		if str.nil?
    		str = MetadataSchema.general_structure(learning_object, "")
    	else
    		str
    	end
	end

	def obtain_general_aggregation_level(learning_object, metadata_general)
		agl = metadata_general.where("name like ?", "%gregation%").first
		if agl.nil?
    		agl = MetadataSchema.general_aggregation_level(learning_object, "")
    	else
    		agl
    	end
	end

	def obtain_general_description(learning_object, metadata_general)
		des = metadata_general.where("name like ?", "%escription%").first
		if des.nil?
    		des = MetadataSchema.general_description(learning_object, "")
    	else
    		des
    	end
	end

	def obtain_general_keywords(learning_object, metadata_general)
		key = metadata_general.where("name like ?", "%eyword%").first
		if key.nil?
    		key = MetadataSchema.general_keyword(learning_object, "")
    	else
    		key
    	end
    end

    #--------------- LIFE CYCLE -------------------

    def obtain_life_cycle_version(learning_object, metadata_life_cycle)
    	ver = metadata_life_cycle.where("name like ?", "%ersion%").first
    	if ver.nil?
    		ver = MetadataSchema.life_cycle_version(learning_object, "")
    	else
    		ver
    	end
    end

    def obtain_life_cycle_status(learning_object, metadata_life_cycle) 
    	st = metadata_life_cycle.where("name like ?", "%tatus%").first
    	if st.nil?
    		st = MetadataSchema.life_cycle_status(learning_object, "")
    	else
    		st
    	end
    end

    def obtain_life_cycle_contribute_role(learning_object, metadata_life_cycle)
    	role = metadata_life_cycle.where("name like ?", "%ole%").first
    	if role.nil?
    		role = MetadataSchema.life_cycle_contribute_role(learning_object, "")
    	else
    		role
    	end
    end

    def obtain_life_cycle_contribute_entity(learning_object, metadata_life_cycle)
    	entity = metadata_life_cycle.where("name like ?", "%ntity%").first
    	if entity.nil?
    		entity = MetadataSchema.life_cycle_contribute_entity(learning_object, "")
    	else
    		entity
    	end
    end

    def obtain_life_cycle_contribute_date(learning_object, metadata_life_cycle)
    	date = metadata_life_cycle.where("name like ?", "%ate%").first
    	if date.nil?
    		date = MetadataSchema.life_cycle_contribute_date(learning_object, "")
    	else
    		date
    	end
    end

    #--------------- EDUCATIONAL -------------------
    def obtain_educational_interactivity_type(learning_object, metadata_educational)
    	it = metadata_educational.where("name ilike ?", "%nteractivity type%").first
    	if it.nil?
    		it = MetadataSchema.educational_interactivity_type(learning_object, "")
    	else
    		it
    	end
    end

    def obtain_educational_learning_resource_types(learning_object, metadata_educational)
    	rt = metadata_educational.where("name ilike ?", "%esource type%").first
    	if rt.nil?
    		rt = MetadataSchema.educational_learning_resource_type(learning_object, "")
    	else
    		rt
    	end
    end

    def obtain_educational_interactivity_level(learning_object, metadata_educational)
    	il = metadata_educational.where("name ilike ?", "%nteractivity level%").first
    	if il.nil?
    		il = MetadataSchema.educational_interactivity_level(learning_object, "")
    	else
    		il
    	end
    end

    def obtain_educational_semantic_density(learning_object, metadata_educational)
    	sd = metadata_educational.where("name like ?", "%ensity%").first
    	if sd.nil?
    		sd = MetadataSchema.educational_semantic_density(learning_object, "")
    	else
    		sd
    	end
    end

    def obtain_educational_intended_end_user_role(learning_object, metadata_educational)
    	ur = metadata_educational.where("name ilike ?", "%user role%").first
    	if ur.nil?
    		ur = MetadataSchema.educational_intended_end_user_role(learning_object, "")
    	else
    		ur
    	end
    end

    def obtain_educational_context(learning_object, metadata_educational)
    	ctx = metadata_educational.where("name ilike ?", "%ontext%").first
    	if ctx.nil?
    		ctx = MetadataSchema.educational_context(learning_object, "")
    	else
    		ctx
    	end
    end

    def obtain_educational_typical_age_range(learning_object, metadata_educational)
    	tar = metadata_educational.where("name ilike ?", "%age range%").first
    	if tar.nil?
    		tar = MetadataSchema.educational_typical_age_range(learning_object, "")
    	else
    		tar
    	end
    end

    def obtain_educational_difficulty(learning_object, metadata_educational)
    	diff = metadata_educational.where("name ilike ?", "%ifficulty%").first
    	if diff.nil?
    		diff = MetadataSchema.educational_difficulty(learning_object, "")
    	else
    		diff
    	end
    end

    def obtain_educational_typical_learning_time(learning_object, metadata_educational)
    	tlt = metadata_educational.where("name ilike ?", "%learning time%").first
    	if tlt.nil?
    		tlt = MetadataSchema.educational_typical_learning_time(learning_object, "")
    	else
    		tlt
    	end
    end

    def obtain_educational_description(learning_object, metadata_educational)
    	ed = metadata_educational.where("name ilike ?", "%description%").first
    	if ed.nil?
    		ed = MetadataSchema.educational_description(learning_object, "")
    	else
    		ed
    	end
    end

    def obtain_educational_language(learning_object, metadata_educational)
    	el = metadata_educational.where("name ilike ?", "%language%").first
    	if el.nil?
    		el = MetadataSchema.educational_language(learning_object, "")
    	else
    		el
    	end
    end

	#--------------- RIGHTS -------------------
    def obtain_rights_cost(learning_object, metadata_rights)
    	rc = metadata_rights.where("name ilike ?", "%cost%").first
    	if rc.nil?
    		rc = MetadataSchema.rights_cost(learning_object, "")
    	else
    		rc
    	end
    end

    def obtain_rights_copy_rights_and_other_restrictions(learning_object, metadata_rights)
    	cror = metadata_rights.where("name ilike ?", "%restriction%").first
    	if cror.nil?
    		cror = MetadataSchema.rights_copy_right_and_other_restrictions(learning_object, "")
    	else
    		cror
    	end
    end

    def obtain_rights_description(learning_object, metadata_rights)
    	des = metadata_rights.where("name ilike ?", "%description%").first
    	if des.nil?
    		des = MetadataSchema.rights_description(learning_object, "")
    	else
    		des
    	end
    end


    #-------- ORGANIZATION
    def obtain_organization_title(learning_object)
    	org_title = learning_object.organizations.first
    	if org_title.nil?
    		org_title = Organization.create(:learning_object_id => learning_object.id, :title => "")
    	else
    		org_title
    	end
    end

    #------ SELECTED TOPICS
    def selected_topics(learning_object)
    	learning_object.contents.map(&:id)
    end

end
