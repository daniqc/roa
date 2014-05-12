class LearningObjectsController < ApplicationController
  before_filter :authorize

  # GET /learning_objects
  # GET /learning_objects.json
  def index
    option = params[:option]
    
    case option
      when "2" # Cuando accedo a los OA de un contenido especifico de un curso
        @content = Content.find(params[:content])
        @learning_objects = @content.learning_objects.paginate(:page => params[:page], :per_page => 10)
        @course = @content.course
        
        respond_to do |format|
          format.html { render 'index_course'}
          format.json { render json: @learning_objects }
        end
      when "3" # Cuando accedo a todos los OA desde la vista de cursos (menu lateral)
        @course = Course.find(params[:course])
        @learning_objects = @course.learning_objects.uniq.paginate(:page => params[:page], :per_page => 10) #uniq es para PostgreSQL

        respond_to do |format|
          format.html { render 'course_material'}
          format.json { render json: @learning_objects }
        end
      else # option=1 accedo desde el menu lateral
        @learning_objects = LearningObject.search(params[:query], params[:search_by], params[:category_id]).paginate(:page => params[:page], :per_page => 10)
        
        respond_to do |format|
          format.html # index.html.erb
          format.json { render json: @learning_objects }
        end
    end    
  end

  def admin_material_search
      @learning_objects = LearningObject.search(params[:query], params[:search_by_admin], params[:category_id]).paginate(:page => params[:page], :per_page => 20)
  
      respond_to do |format|
        format.html { render 'admin_index'}
        format.json { render json: @learning_objects }
      end
      authorize! :admin_material_search, LearningObject
  end

  # GET /learning_objects/1
  # GET /learning_objects/1.json
  def show
    @learning_object = LearningObject.find(params[:id])
    @comment = Comment.new
    @comments = @learning_object.comments.arrange(:order => :created_at)

    # Reviso si el usuario actual puede evaluar el objeto (no puede evaluarlo dos veces)
    @can_evaluate = current_person.ratings.where(:learning_object_id => @learning_object.id).empty?
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @learning_object }
    end
    authorize! :show, LearningObject
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
    @metadata_general = @learning_object.metadata_general
    @metadata_life_cycle = @learning_object.metadata_life_cycle
    @metadata_educational = @learning_object.metadata_educational
    @metadata_rights = @learning_object.metadata_rights
    authorize! :edit, LearningObject
  end

  # POST /learning_objects
  # POST /learning_objects.json
  def create
    @learning_object = LearningObject.new(params[:learning_object])
    
    respond_to do |format|
      if @learning_object.save
        format.html { redirect_to @learning_object, notice: 'El objeto fue correctamente creado!' }
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
    # render :nothing => true
    @learning_object = LearningObject.find(params[:id])

    # Actualizo el titulo de la organizacion
    Organization.update_title(params[:organization_title_id], params[:organization_title])

    # Actualizo los contenidos
    LearningMaterial.update_contents(@learning_object, params[:content_id])

    # Actualizo los metadatos generales
    LoMetadataSchema.update_general_metadata(@learning_object,
      params[:general_title_id], params[:general_title],
      params[:general_identifier_id], params[:general_identifier],
      params[:general_languages_id], params[:general_languages],
      params[:general_coverage_id], params[:general_coverage],
      params[:general_structure_id], params[:general_structure],
      params[:general_aggregation_level_id], params[:general_aggregation_level],
      params[:general_description_id], params[:general_description],
      params[:general_keywords_id], params[:general_keywords])

    # Actualizo los metadatos del ciclo de vida
    LoMetadataSchema.update_life_cycle_metadata(
      params[:life_cycle_version_id], params[:life_cycle_version],
      params[:life_cycle_status_id], params[:life_cycle_status],
      params[:life_cycle_contribute_role_id], params[:life_cycle_contribute_role],
      params[:life_cycle_contribute_entity_id], params[:life_cycle_contribute_entity],
      params[:life_cycle_contribute_date_id], params[:life_cycle_contribute_date])

    # Actualizo los metadatos educacionales
    LoMetadataSchema.update_educational_metadata(
      params[:educational_interactivity_type_id], params[:educational_interactivity_type],
      params[:educational_learning_resource_types_id], params[:educational_learning_resource_types],
      params[:educational_interactivity_level_id], params[:educational_interactivity_level],
      params[:educational_semantic_density_id], params[:educational_semantic_density],
      params[:educational_intended_end_user_role_id], params[:educational_intended_end_user_role],
      params[:educational_context_id], params[:educational_context],
      params[:educational_typical_age_range_id], params[:educational_typical_age_range],
      params[:educational_difficulty_id], params[:educational_difficulty],
      params[:educational_typical_learning_time_id], params[:educational_typical_learning_time],
      params[:educational_description_id], params[:educational_description],
      params[:educational_language_id], params[:educational_language])

    # Actualizo los metadatos de derechos de autor
    LoMetadataSchema.update_rights_metadata(
      params[:rights_cost_id], params[:rights_cost],
      params[:rights_copy_rights_and_other_restrictions_id], params[:rights_copy_rights_and_other_restrictions],
      params[:rights_description_id], params[:rights_description])

    # respond_to do |format|
    #   if organization_title.update_attributes(:title => params[:organization_title]) 
    #     format.html { redirect_to({:action => 'admin_material_search'}, notice: 'Learning object was successfully updated.')}
    #   else
    #     # redirect_to({:action => 'admin_material_search'}, notice: 'Learning object was successfully updated.')
    #     format.html { redirect_to :action => 'admin_material_search', notice: 'Un error ha ocurrido!'  }
    #   end
    # end
    respond_to do |format|
      format.html { redirect_to({:action => 'admin_material_search'}, notice: 'El material fue correctamente actualizado!')}
    end
  end

  # DELETE /learning_objects/1
  # DELETE /learning_objects/1.json
  def destroy
    @learning_object = LearningObject.find(params[:id])
    @learning_object.destroy

    #Elimino la carpeta donde se alojaba el objeto


    respond_to do |format|
      format.html { redirect_to({:action => 'admin_material_search'}, notice: 'El material fue correctamente eliminado!') }
      format.json { head :no_content }
    end
    authorize! :destroy, LearningObject
  end

  def upload_material
    authorize! :upload_material, LearningObject
  end

  
  def unzip_correct_zip_file(reload_zip_file, content_id)
    # Guardo el registro en base de datos
    @learning_object = LearningObject.create(:file => reload_zip_file)

    
    # Descomprimo el zip y guardo los archivos en la carpeta correspondiente.
    Zip::ZipFile.open(reload_zip_file.path) do |zipfile|
      zipfile.each do |file|
        # Le doy el path donde debe guardar cada uno de los archivos
        f_path = File.join(@learning_object.get_folder_path, file.name)
        FileUtils.mkdir_p(File.dirname(f_path))
        zipfile.extract(file,f_path) unless File.exist?(f_path)
      end
    end

    # Soluciono los problemas de tilde de los archivos
    rename_files(@learning_object)

    # Guardo los tópicos al cual pertenece
    save_contents(@learning_object, content_id)

    # Leo el archivo xml
    read_manifest_xml(@learning_object)

    #Elimino el zip file
    File.delete("#{Rails.root}/public/system/learning_objects/" +@learning_object.id.to_s+"/"+@learning_object.file_file_name.to_s)

    respond_to do |format|
      format.html { render "learning_objects/upload_lo", notice: 'El archivo fue subido correctamente!' }
    end
  end
  # Cuando el usuario elige la opcion de subir un zip file
  
  def unzip_lo
    reload_zip_file = params[:reload_zip_file]
    content_id = params[:content_id]

    extension = File.extname(reload_zip_file.original_filename)

    if extension != ".zip"
      flash[:error] = "El formato del archivo es incorrecto. Por favor subir un paquete .zip"
      redirect_to upload_material_path
    elsif content_id.nil?
      flash[:error] = "Debe seleccionar un tema para subir el objeto."
      redirect_to upload_material_path
    else
      unzip_correct_zip_file(reload_zip_file, content_id)
    end
  end

  def save_contents(learning_object, contents_ids)
    contents = Content.contents(contents_ids)
    contents.each do |content|
      LearningMaterial.save_content(learning_object,content)
    end
  end

  #Cuando el usuario elige subir un objeto sin formato RELOAD (aqui se pide escribir los metadatos)
  def new_material
    
    # Inserto el objeto con el título. Esto para entregar el ID a la creación de los metadatos posteriormente.
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
    # MetadataSchema.general_keyword(@learning_object, params[:general_keywords].split(","))
    MetadataSchema.general_keyword(@learning_object, params[:general_keywords])
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
    # MetadataSchema.educational_learning_resource_type(@learning_object, params[:educational_learning_resource_types].split(","))
    MetadataSchema.educational_learning_resource_type(@learning_object, params[:educational_learning_resource_types])
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
      FileUtils.mkdir_p(File.dirname(path))
      File.open(path, "wb") { |f| f.write(item.read) }

      Item.create(:organization_id => organization.id, :title => File.basename(item.original_filename, ".*"), :resource_ref_id => URI.encode(item.original_filename))
    end

    # Guardo los tópicos al cual pertenece
    save_contents(@learning_object, params[:content_id])

    respond_to do |format|
      format.html { render "learning_objects/upload_lo", notice: 'El material fue creado correctamente!' }
    end
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
    MetadataSchema.general_identifier(learning_object, @identifier)

    # General:titulo
    @title = doc.at_xpath("//general//title//langstring").text
    learning_object.name = @title
    learning_object.save
    MetadataSchema.general_title(learning_object, @title)
        
    # General:lenguajes
    languages = doc.xpath("//general//language")
    array_languages = []
    
    languages.each do |language|
      array_languages << language.text
    end
    @languages = array_languages.join(",")
    MetadataSchema.general_language(learning_object, array_languages)

    # General:descripcion
    @description = doc.at_xpath("//general//description//langstring").text
    MetadataSchema.general_description(learning_object, @description)
    
    # General:keywords
    keywords = doc.xpath("//general//keyword//langstring")
    array_keywords = []
    
    keywords.each do |key|
      array_keywords << key.text
    end
    @keywords = array_keywords.join(",")
    MetadataSchema.general_keyword(learning_object, @keywords)

    # General:coverage
    @coverage = doc.xpath("//general//coverage//langstring").text
    MetadataSchema.general_coverage(learning_object, @coverage)

    # General:structure
    @structure = doc.xpath("//general//structure//value//langstring").text
    MetadataSchema.general_structure(learning_object,@structure)

    # General:aggregation level
    @aggregationlevel = doc.xpath("//general//aggregationlevel//value//langstring").text
    MetadataSchema.general_aggregation_level(learning_object, @aggregationlevel)
  end

  def read_life_cycle_metadata(doc, learning_object)
    
    version = doc.xpath("//lifecycle//version//langstring").text
    MetadataSchema.life_cycle_version(learning_object, version)

    status = doc.xpath("//lifecycle//status//value//langstring").text
    MetadataSchema.life_cycle_status(learning_object, status)

    contribution = doc.xpath("//lifecycle//contribute")
    contribution.each do |contribute|
      @contribute_role = contribute.xpath("role//value//langstring").text
      MetadataSchema.life_cycle_contribute_role(learning_object, @contribute_role)

      @contribute_entity = contribute.xpath("centity//vcard").text
      MetadataSchema.life_cycle_contribute_entity(learning_object, @contribute_entity)

      contribute_date = contribute.xpath("date//datetime").text
      MetadataSchema.life_cycle_contribute_date(learning_object, contribute_date)
    end
  end

  def read_educational_metadata(doc, learning_object)
    
    interactivitytype = doc.xpath("//educational//interactivitytype//value//langstring").text
    MetadataSchema.educational_interactivity_type(learning_object, interactivitytype)

    learningresourcetypes = doc.xpath("//educational//learningresourcetype")
    learning_resource_types = []
    learningresourcetypes.each do |learningresourcetype|
      learning_resource_types << learningresourcetype.xpath("value//langstring").text
    end
    lrt = learning_resource_types.join(",")
    # MetadataSchema.educational_learning_resource_type(learning_object, learning_resource_types)
    MetadataSchema.educational_learning_resource_type(learning_object, lrt)

    interactivitylevel = doc.xpath("//educational//interactivitylevel//value//langstring").text
    MetadataSchema.educational_interactivity_level(learning_object, interactivitylevel)

    semanticdensity = doc.xpath("//educational//semanticdensity//value//langstring").text
    MetadataSchema.educational_semantic_density(learning_object, semanticdensity)


    intendedenduserrole = doc.xpath("//educational//intendedenduserrole//value//langstring").text
    MetadataSchema.educational_intended_end_user_role(learning_object, intendedenduserrole)

    context = doc.xpath("//educational//context//value//langstring").text
    MetadataSchema.educational_context(learning_object, context)

    typicalagerange = doc.xpath("//educational//typicalagerange//langstring").text
    MetadataSchema.educational_typical_age_range(learning_object, typicalagerange)

    difficulty = doc.xpath("//educational//difficulty//value//langstring").text
    MetadataSchema.educational_difficulty(learning_object, difficulty)

    typicallearningtime = doc.xpath("//educational//typicallearningtime//datetime").text
    MetadataSchema.educational_typical_learning_time(learning_object, typicallearningtime)

    description = doc.xpath("//educational//description//langstring").text
    MetadataSchema.educational_description(learning_object, description)

    language =  doc.xpath("//educational//language").text
    MetadataSchema.educational_language(learning_object, language)
  end

  def read_rights_metadata(doc, learning_object)
    
    cost = doc.xpath("//rights//cost//value//langstring").text
    MetadataSchema.rights_cost(learning_object, cost)

    copyrightandotherrestrictions = doc.xpath("//rights//copyrightandotherrestrictions//value//langstring").text
    MetadataSchema.rights_copy_right_and_other_restrictions(learning_object, copyrightandotherrestrictions)

    description = doc.xpath("//rights//description//langstring").text
    MetadataSchema.rights_description(learning_object, description)
  end

  def read_organizations(doc, learning_object)
    organizations = doc.xpath("//organizations//organization")
    
    organizations.each do |org|
      identifier = org["identifier"]
      structure = org["structure"]
      title = org.xpath("title").text
      db_org = Organization.create_organization(learning_object, identifier, structure, title)

      # Lectura de los items
      read_items(doc,org,db_org)
    end
    
  end

  def read_items(doc,organization, db_org)
    items = organization.xpath("item")
    items.each do |item|
      identifier = item["identifier"]
      isvisible = item["isvisible"]
      identifierref = item["identifierref"]
      title = item.xpath("title").text
      
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

  def write_metadata_file(learning_object, folder)
    # Obtengo los metadatos del OA
    lo_metadata = learning_object.lo_metadata_schemas

    filename = "ROA_metadata.txt"
    path = File.join(folder, filename)
    FileUtils.mkdir_p(File.dirname(path))
    File.open(path, "w") do |f|
      lo_metadata.each do |data|
        f.puts "[ #{data.metadata_schema.root.name} ] #{data.metadata_schema.name}: #{data.value}"
      end
    end
  end

  def download_material
    @learning_object = LearningObject.find(params[:id])
        
    # Se verifica por que medio se sube el OA
    if @learning_object.file_file_name.nil?
      material_path = "#{Rails.root}/public/system/learning_objects/#{@learning_object.id.to_s}/#{@learning_object.name}.zip"
    else
      material_path = "#{Rails.root}/public/system/learning_objects/" +@learning_object.id.to_s+"/"+@learning_object.file_file_name.to_s
    end    
    
    # Se elimina cualquier zip que exista anteriormente
    File.delete(material_path) if File.exist?(material_path)

    # Obtengo el folder
    folder = @learning_object.get_folder_path
    
    # Creo el nombre del zip
    if @learning_object.file_file_name.nil?
      zipfile_name = "#{folder}/#{@learning_object.name}.zip"
      # write_metadata_file(@learning_object, folder)
    else
      zipfile_name = "#{folder}/#{@learning_object.file_file_name}"
    end
    write_metadata_file(@learning_object, folder)

    # Obtengo los archivos que hay en el folder
    input_files = Dir.entries(folder)
    
    Zip::ZipFile.open(zipfile_name, Zip::ZipFile::CREATE) do |zipfile|
      input_files.reject {|fn| File.directory?(fn) }.each do |filename|
        # logger.debug "++++estoy enviando: #{filename}"
        zipfile.add(filename, folder + '/' + filename)
      end
      # zipfile.get_output_stream("myFile") { |os| os.write "myFile contains just this" }
    end
    send_file zipfile_name, :type => 'application/zip', :disposition => 'attachment', :filename => @learning_object.file_file_name
  end

  def rename_files(learning_object)
    # Obtengo el folder
    folder = learning_object.get_folder_path

    # Obtengo los nombres de los archivos que contiene el folder
    input_files = Dir.entries(folder)

    # Por cada nombre hago en rename del archivo.
    input_files.reject {|fn| File.directory?(fn) }.each do |filename|
        original_name = learning_object.get_folder_path+"/"+filename
        new_name = learning_object.get_folder_path+"/"+filename.encode('iso-8859-1').force_encoding('utf-8')
        File.rename(original_name, new_name)
      end
  end
end