class LearningObjectsController < ApplicationController
  # GET /learning_objects
  # GET /learning_objects.json
  def index
    # @learning_objects = LearningObject.all
    # @learning_objects = LearningObject.last(10).reverse
    option = params[:option]
    
    case option
      when "2"
        @content = Content.find(params[:content])
        @learning_objects = @content.learning_objects
        @course = @content.course
        
        respond_to do |format|
          format.html { render 'index_course'}
          format.json { render json: @learning_objects }
        end
      when "3"
        @course = Course.find(params[:course])
        @learning_objects = @course.learning_objects

        respond_to do |format|
          format.html { render 'course_material'}
          format.json { render json: @learning_objects }
        end
      else
        @learning_objects = LearningObject.search(params[:query], params[:search_by], params[:category_id])
        
        respond_to do |format|
          format.html # index.html.erb
          format.json { render json: @learning_objects }
        end
    end    
    
    # @learning_objects.paginate(:page => params[:page]).order('id DESC')
    # @learning_objects = LearningObject.page(params[:page]).per_page(5)
  end

  def admin_material_search
      @learning_objects = LearningObject.search(params[:query], params[:search_by], params[:category_id])

      respond_to do |format|
        format.html { render 'admin_index'}
        format.json { render json: @learning_objects }
      end
  end

  # GET /learning_objects/1
  # GET /learning_objects/1.json
  def show
    @learning_object = LearningObject.find(params[:id])
    @comment = Comment.new
    @comments = @learning_object.comments.arrange(:order => :created_at)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @learning_object }
    end
  end

  # GET /learning_objects/new
  # GET /learning_objects/new.json
  def new
    @learning_object = LearningObject.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @learning_object }
    end
  end

  # GET /learning_objects/1/edit
  def edit
    @learning_object = LearningObject.find(params[:id])
  end

  # POST /learning_objects
  # POST /learning_objects.json
  def create
    @learning_object = LearningObject.new(params[:learning_object])
    
    respond_to do |format|
      if @learning_object.save
        format.html { redirect_to @learning_object, notice: 'Learning object was successfully created.' }
        format.json { render json: @learning_object, status: :created, location: @learning_object }
      else
        format.html { render action: "new" }
        format.json { render json: @learning_object.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /learning_objects/1
  # PUT /learning_objects/1.json
  def update
    @learning_object = LearningObject.find(params[:id])

    respond_to do |format|
      if @learning_object.update_attributes(params[:learning_object])
        format.html { redirect_to @learning_object, notice: 'Learning object was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @learning_object.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /learning_objects/1
  # DELETE /learning_objects/1.json
  def destroy
    @learning_object = LearningObject.find(params[:id])
    @learning_object.destroy

    respond_to do |format|
      format.html { redirect_to learning_objects_url }
      format.json { head :no_content }
    end
  end

  def upload_material
    #content = Content.find(params[:id])
    #logger.debug "THE CONTENT IS #{content.name}"
  end

  # Cuando el usuario elige la opcion de subir un zip file
  def unzip_lo
    
    reload_zip_file = params[:reload_zip_file]
    
    # Guardo el registro en base de datos
    @learning_object = LearningObject.create(:file => reload_zip_file)

    
    # Descomprimo el zip y guardo los archivos en la carpeta correspondiente.
    Zip::ZipFile.open(reload_zip_file.path) do |zipfile|
      zipfile.each do |file|
        # le doy el path donde debe guardar cada uno de los archivos
        f_path = File.join(@learning_object.get_folder_path, file.name)
        FileUtils.mkdir_p(File.dirname(f_path))
        zipfile.extract(file,f_path) unless File.exist?(f_path)
      end
    end

    # Guardo el tópico al cual pertenece
    LearningMaterial.create(
      :content_id => params[:learning_object][:content_id], 
      :learning_object_id => @learning_object.id, 
      :course_id => params[:learning_object][:course_id]
      )

    # Leo el archivo xml
    read_manifest_xml(@learning_object)

    respond_to do |format|
      format.html { render "learning_objects/upload_lo", notice: 'The file was successfully upload!' }
    end
    # logger.debug "los parametros son: #{params[:learning_object][:course_id]}, #{params[:learning_object][:content_id]}"
    # render :nothing => true
  end

  #Cuando el usuario elige subir un objeto sin formato RELOAD (aqui se pide escribir los metadatos)
  def new_material
    
    # Inserto el objeto con el título. ESto para entregar el ID a la creación de los metadatos posteriormente.
    @learning_object = LearningObject.create(:name => params[:general_title])
    @keywords = params[:general_keywords]
    @contribute_role = params[:life_cycle_contribute_role]
    @contribute_entity = params[:life_cycle_contribute_entity]
    @description = params[:general_description]

    
    #Metadatos generales. Los inserto en la base de datos
    MetadataSchema.general_identifier(@learning_object, params[:general_identifier])
    MetadataSchema.general_title(@learning_object, params[:general_title])
    MetadataSchema.general_language(@learning_object, params[:general_languages].split(","))
    MetadataSchema.general_description(@learning_object, params[:general_description])
    MetadataSchema.general_keyword(@learning_object, params[:general_keywords].split(","))
    MetadataSchema.general_coverage(@learning_object, params[:general_coverage])
    MetadataSchema.general_structure(@learning_object, params[:general_structure])
    MetadataSchema.general_aggregation_level(@learning_object, params[:general_aggregation_level])


    #Metadatos del ciclo de vida. Los inserto en la base de datos
    MetadataSchema.life_cycle_version(@learning_object, params[:life_cycle_version])
    MetadataSchema.life_cycle_status(@learning_object, params[:life_cycle_status])
    MetadataSchema.life_cycle_contribute_role(@learning_object, params[:life_cycle_contribute_role])
    MetadataSchema.life_cycle_contribute_entity(@learning_object, params[:life_cycle_contribute_entity])
    MetadataSchema.life_cycle_contribute_date(@learning_object, params[:life_cycle_contribute_date])

    #Metadatos educacionales. Los inserto en la base de datos
    MetadataSchema.educational_interactivity_type(@learning_object, params[:educational_interactivity_type])
    MetadataSchema.educational_learning_resource_type(@learning_object, params[:educational_learning_resource_types].split(","))
    MetadataSchema.educational_interactivity_level(@learning_object, params[:educational_interactivity_level])
    MetadataSchema.educational_semantic_density(@learning_object, params[:educational_semantic_density])
    MetadataSchema.educational_intended_end_user_role(@learning_object, params[:educational_intended_end_user_role])
    MetadataSchema.educational_context(@learning_object, params[:educational_context])
    MetadataSchema.educational_typical_age_range(@learning_object, params[:educational_typical_age_range])
    MetadataSchema.educational_difficulty(@learning_object, params[:educational_difficulty])
    MetadataSchema.educational_typical_learning_time(@learning_object, params[:educational_typical_learning_time])
    MetadataSchema.educational_description(@learning_object, params[:educational_description])
    MetadataSchema.educational_language(@learning_object, params[:educational_language])

    #Metadatos derechos de autor. Los inserto en la base de datos
    MetadataSchema.rights_cost(@learning_object, params[:rights_cost])
    MetadataSchema.rights_copy_right_and_other_restrictions(@learning_object, params[:rights_copy_rights_and_other_restrictions])
    MetadataSchema.rights_description(@learning_object, params[:rights_description])
    
    #Inserto el título de la organizacion del OA en la base de datos
    organization = Organization.create(:learning_object_id => @learning_object.id, :title => params[:organization_title])
    
    #Inserto los items en la base de datos
    params[:new_item].each do |item|
      path = File.join(@learning_object.get_folder_path, item.original_filename)
      logger.debug "****el nombre del archivo es: #{item.original_filename}"
      logger.debug "****el nombre del archivo es: #{File.basename(item.original_filename, ".*")}"
      FileUtils.mkdir_p(File.dirname(path))
      File.open(path, "wb") { |f| f.write(item.read) }

      Item.create(:organization_id => organization.id, :title => File.basename(item.original_filename, ".*"), :resource_ref_id => URI.encode(item.original_filename))
    end

    # Guardo el tópico al cual pertenece
    LearningMaterial.create(
      :content_id => params[:learning_object][:content_id], 
      :learning_object_id => @learning_object.id, 
      :course_id => params[:learning_object][:course_id]
      )

    respond_to do |format|
      format.html { render "learning_objects/upload_lo", notice: 'The file was successfully upload!' }
    end
    # logger.debug "los parametros son: #{params[:learning_object][:course_id]}, #{params[:learning_object][:content_id]}"
    # render :nothing => true
  end

  def read_languages(languages)
    array_languages = []

    languages.each do |language|
      array_languages << language.text
    end

  end

  def read_manifest_xml(learning_object)
    # Dir.glob obtiene un array de archivos con extensión .xml (en nuestro caso siempre sera un archivo xml)
    xml_path = Dir.glob(learning_object.get_xml_files)
    
    # Indico el primer path encontrado por xml_path (con first)
    f = File.open(xml_path.first)
    
    doc = Nokogiri::XML(f)
    
    #Elimino los namespaces para hacer mas facil la lectura del xml.
    doc.remove_namespaces!
    
    # Leo los metadatos
    read_general_metadata(doc, learning_object)
    read_life_cycle_metadata(doc, learning_object)
    read_educational_metadata(doc, learning_object)
    read_rights_metadata(doc, learning_object)

    # Leo la organización
    read_organizations(doc, learning_object)
    # Leo los recursos
    #read_resources(doc, learning_object)

    f.close
  end

  def read_general_metadata(doc, learning_object)
    # logger.debug "********** GENERAL METADATA *****************"

    # General:identificador
    @identifier = doc.at_xpath("//general//identifier").text
    # logger.debug "IDENTIFIER: #{@identifier}"
    MetadataSchema.general_identifier(learning_object, @identifier)

    # General:titulo
    @title = doc.at_xpath("//general//title//langstring").text
    # logger.debug "TITULO: #{@title}"
    learning_object.name = @title
    learning_object.save
    MetadataSchema.general_title(learning_object, @title)
        
    # General:lenguajes
    languages = doc.xpath("//general//language")
    array_languages = []
    
    languages.each do |language|
      # logger.debug "LANGUAGE: #{language.text}"
      array_languages << language.text
    end
    @languages = array_languages.join(",")
    MetadataSchema.general_language(learning_object, array_languages)

    # General:descripcion
    @description = doc.at_xpath("//general//description//langstring").text
    # logger.debug "DESCRIPTION: #{@description}"
    MetadataSchema.general_description(learning_object, @description)
    
    # General:keywords
    keywords = doc.xpath("//general//keyword//langstring")
    array_keywords = []
    
    keywords.each do |key|
      # logger.debug "KEYWORD: #{key.text}"
      array_keywords << key.text
    end
    @keywords = array_keywords.join(",")
    MetadataSchema.general_keyword(learning_object, array_keywords)

    # General:coverage
    @coverage = doc.xpath("//general//coverage//langstring").text
    # logger.debug "coverage #{@coverage}"
    MetadataSchema.general_coverage(learning_object, @coverage)

    # General:structure
    @structure = doc.xpath("//general//structure//value//langstring").text
    # logger.debug "structure #{@structure}"
    MetadataSchema.general_structure(learning_object,@structure)

    # General:aggregation level
    @aggregationlevel = doc.xpath("//general//aggregationlevel//value//langstring").text
    # logger.debug "aggregationlevel #{@aggregationlevel}"
    MetadataSchema.general_aggregation_level(learning_object, @aggregationlevel)
  end

  def read_life_cycle_metadata(doc, learning_object)
    # logger.debug "********** LIFE CYCLE METADATA *****************"

    version = doc.xpath("//lifecycle//version//langstring").text
    # logger.debug "version: #{version}"
    MetadataSchema.life_cycle_version(learning_object, version)

    status = doc.xpath("//lifecycle//status//value//langstring").text
    # logger.debug "status: #{status}"
    MetadataSchema.life_cycle_status(learning_object, status)

    contribution = doc.xpath("//lifecycle//contribute")
    contribution.each do |contribute|
      @contribute_role = contribute.xpath("role//value//langstring").text
      # logger.debug "contribute_role: #{contribute_role}"
      MetadataSchema.life_cycle_contribute_role(learning_object, @contribute_role)

      @contribute_entity = contribute.xpath("centity//vcard").text
      # logger.debug "contribute_entity: #{contribute_entity}"
      MetadataSchema.life_cycle_contribute_entity(learning_object, @contribute_entity)

      contribute_date = contribute.xpath("date//datetime").text
      # logger.debug "contribute_date: #{contribute_date}"
      MetadataSchema.life_cycle_contribute_date(learning_object, contribute_date)
    end
  end

  def read_educational_metadata(doc, learning_object)
    # logger.debug "********** EDUCATIONAL METADATA *****************"

    interactivitytype = doc.xpath("//educational//interactivitytype//value//langstring").text
    # logger.debug "interactivitytype: #{interactivitytype}"
    MetadataSchema.educational_interactivity_type(learning_object, interactivitytype)

    learningresourcetypes = doc.xpath("//educational//learningresourcetype")
    learning_resource_types = []
    learningresourcetypes.each do |learningresourcetype|
      learning_resource_types << learningresourcetype.xpath("value//langstring").text
      # logger.debug "learningresourcetype_: #{learningresourcetype.xpath("value//langstring").text}"
    end
    MetadataSchema.educational_learning_resource_type(learning_object, learning_resource_types)

    interactivitylevel = doc.xpath("//educational//interactivitylevel//value//langstring").text
    # logger.debug "interactivitylevel: #{interactivitylevel}"
    MetadataSchema.educational_interactivity_level(learning_object, interactivitylevel)

    semanticdensity = doc.xpath("//educational//semanticdensity//value//langstring").text
    # logger.debug "semanticdensity: #{semanticdensity}"
    MetadataSchema.educational_semantic_density(learning_object, semanticdensity)


    intendedenduserrole = doc.xpath("//educational//intendedenduserrole//value//langstring").text
    # logger.debug "intendedenduserrole: #{intendedenduserrole}"
    MetadataSchema.educational_intended_end_user_role(learning_object, intendedenduserrole)

    context = doc.xpath("//educational//context//value//langstring").text
    # logger.debug "context: #{context}"
    MetadataSchema.educational_context(learning_object, context)

    typicalagerange = doc.xpath("//educational//typicalagerange//langstring").text
    # logger.debug "typicalagerange: #{typicalagerange}"
    MetadataSchema.educational_typical_age_range(learning_object, typicalagerange)

    difficulty = doc.xpath("//educational//difficulty//value//langstring").text
    # logger.debug "difficulty: #{difficulty}"
    MetadataSchema.educational_difficulty(learning_object, difficulty)

    typicallearningtime = doc.xpath("//educational//typicallearningtime//datetime").text
    # logger.debug "typicallearningtime: #{typicallearningtime}"
    MetadataSchema.educational_typical_learning_time(learning_object, typicallearningtime)

    description = doc.xpath("//educational//description//langstring").text
    # logger.debug "description: #{description}"
    MetadataSchema.educational_description(learning_object, description)

    language =  doc.xpath("//educational//language").text
    # logger.debug "language: #{language}"
    MetadataSchema.educational_language(learning_object, language)
  end

  def read_rights_metadata(doc, learning_object)
    # logger.debug "********** RIGHTS METADATA *****************"

    cost = doc.xpath("//rights//cost//value//langstring").text
    # logger.debug "cost: #{cost}"
    MetadataSchema.rights_cost(learning_object, cost)

    copyrightandotherrestrictions = doc.xpath("//rights//copyrightandotherrestrictions//value//langstring").text
    # logger.debug "copyrightandotherrestrictions: #{copyrightandotherrestrictions}"
    MetadataSchema.rights_copy_right_and_other_restrictions(learning_object, copyrightandotherrestrictions)

    description = doc.xpath("//rights//description//langstring").text
    # logger.debug "description: #{description}"
    MetadataSchema.rights_description(learning_object, description)
  end

  def read_organizations(doc, learning_object)
    organizations = doc.xpath("//organizations//organization")
    #logger.debug "organizations: #{organizations}"
    
    organizations.each do |org|
      identifier = org["identifier"]
      #logger.debug "*** organization identifier: #{identifier}"
      structure = org["structure"]
      #logger.debug "**** organization structure: #{structure}"
      title = org.xpath("title").text
      db_org = Organization.create_organization(learning_object, identifier, structure, title)

      # Lectura de los items
      read_items(doc,org,db_org)
    end
    
  end

  def read_items(doc,organization, db_org)
    items = organization.xpath("item")
    #logger.debug "items: #{items}"
    items.each do |item|
      identifier = item["identifier"]
      #logger.debug "*** item identifier: #{identifier}"
      isvisible = item["isvisible"]
      #logger.debug "*** item isvisible: #{isvisible}"
      identifierref = item["identifierref"]
      # logger.debug "*** item identifierref: #{identifierref}"
      title = item.xpath("title").text
      # logger.debug "**** item title #{title}"
      
      # Leo los recursos
      resource = doc.xpath("//resources//resource[@identifier='#{identifierref}']")
      read_files(resource,db_org,title)
      
    end
  end

  # def read_resources(doc, learning_object)
  #   # logger.debug "**** resources******"
  #   resources = doc.xpath("//resources//resource")

  #   resources.each do |resource|
  #     identifier = resource["identifier"]
  #     resource_type =  resource["type"]
  #     #principal_href = URI.decode(resource["href"])
  #     principal_href = resource["href"]
  #     db_resource = Resource.create_resource(learning_object, identifier, resource_type, principal_href)

  #     #Leo los archivos del resource
  #     read_files(resource,db_resource)
  #   end
  # end

  def read_files(resource,db_org,title)
    files = resource.xpath("file")
      files.each do |file|
        # file_href = URI.decode(file["href"])
        file_href = file["href"]
        Item.create_item(db_org.id, title, file_href)
      end
  end

  # def read_files(resource,db_resource)
  #   files = resource.xpath("file")
  #     files.each do |file|
  #       # file_href = URI.decode(file["href"])
  #       file_href = file["href"]
  #       ResourceFile.create_resource_file(db_resource,file_href)
  #     end
  # end

end
