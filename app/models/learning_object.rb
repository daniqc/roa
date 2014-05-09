class LearningObject < ActiveRecord::Base
  has_many :organizations, :dependent => :destroy
  has_many :resources, :dependent => :destroy
  has_many :lo_metadata_schemas, :dependent => :destroy
  has_many :metadata_schemas, :through => :lo_metadata_schemas
  has_many :learning_materials, :dependent => :destroy
  has_many :courses, :through => :learning_materials
  has_many :contents, :through => :learning_materials
  has_many :comments, :dependent => :destroy
  has_many :ratings, :dependent => :destroy

  attr_accessible :name, :file, :id, :file_file_name, :course_ids, :content_ids
  has_attached_file :file,
  					:url => "/system/learning_objects/:id/:basename.:extension",
  					:path => ":rails_root/public/system/learning_objects/:id/:basename.:extension", :keep_old_files => :version_condition_met?

  #validates_attachment_presence :file

  accepts_nested_attributes_for :organizations, :reject_if => lambda { |a| a[:title].blank? }, :allow_destroy => true

  include PgSearch
  pg_search_scope :search, :against => :name
  
  # Actualiza el nombre del objeto en base de dato (atributo :name)
  def update_name
  	filename = File.basename(get_zip_path, ".zip")
  	update_attributes(:name => filename)
  end

  def get_zip_path
  	"/system/learning_objects/"+id.to_s+"/"+file_file_name.to_s
  end

  def get_zip_path_new
  	# Dir.glob("/system/learning_objects/"+id.to_s+"/*.zip")
  	#Rails.root.to_s + "/public/system/documents/" + self.project.id.to_s
    Rails.root.to_s + "/public/system/learning_objects/" +id.to_s+"/"+file_file_name.to_s
  end

  def get_folder_path
    Rails.root.to_s + "/public/system/learning_objects/" + id.to_s
  end

  def get_xml_files
  	"public/system/learning_objects/"+id.to_s+"/*.xml"
  end

  def get_zip_file
    "public/system/learning_objects/"+id.to_s+"/*.zip"
  end

  def get_file_url
    "/system/learning_objects/"+id.to_s+"/"+id.to_s+"/"+(live? ? versions.length : version.index).to_s+"/"+document_file_name
  end

  def role
    life_cycle_attributes = MetadataSchema.life_cycle
    role_attribute = life_cycle_attributes.where("name like ?", "%ole%").first.id
    logger.debug "role attribute: #{role_attribute}, learning_object: #{self.id}"
    LoMetadataSchema.where(:metadata_schema_id => role_attribute, :learning_object_id => self.id).first.value
  end

  def description
    general_attributes = MetadataSchema.general
    description_attribute = general_attributes.where("name like ?", "%escriptio%").first.id
  end

  def self.search(query, search_by, category_value)
    # esta query busca de acuerdo al parametro de entrada.
    # search_by = 1 busca por nombre del objeto
    # search_by = 2 busca por nombre del autor
    # search_by = 3 busca por nombre de la categoría
    # search_by = 4 busca por palabras clave
    # Primero transformo la query de busqueda en formato or (|) para la tsquery
    q = query.split if query
    new_query = q.join('|') if q
    # logger.debug "+++++++++++++ la query es: #{new_query}"

    if query.present? || category_value.present?
      case search_by
        when "1"
          # logger.debug "ESTOY EN EL SEARCH BY 1 POR NOMBRE"
          #where('name @@ ?', query).order("created_at desc")
          where "to_tsvector('spanish', name) @@ to_tsquery('spanish', '#{new_query}')"
          # where("name like ?" , query).order("created_at desc")
        when "2" 
          # logger.debug "ESTOY EN EL SEARCH BY 2 POR AUTOR"
          author_id = MetadataSchema.life_cycle.where("name like ?", "%ole%").first.id
          # result = LoMetadataSchema.where('metadata_schema_id = ? and value = @@ ?', author_id, query).map(&:learning_object_id)
          result = LoMetadataSchema.where('metadata_schema_id = ? and value ilike ?', author_id, query).map(&:learning_object_id)
          where(:id => result).order("created_at desc")
        when "3"
          # logger.debug "ESTOY EN EL SEARCH BY 3 POR CATEGORiA"
          Course.find(category_value).learning_objects.uniq
        when "4"
          # logger.debug "ESTOY EN EL SEARCH BY 4 POR PALABRAS CLAVE"
          keywords_id = MetadataSchema.general.where("name like ?", "%eyword%").first.id
          # result = LoMetadataSchema.where('metadata_schema_id = ? and value @@ ?', keywords_id, query).map(&:learning_object_id)
          result = LoMetadataSchema.where('metadata_schema_id = ? and value = ?', keywords_id, query).map(&:learning_object_id)
           where(:id => result).order("created_at desc")
        else
          # logger.debug "ESTOY EN EL ELSE"
          order("created_at desc").all
      end
    else
      order("created_at desc").all
    end
  end

  def lo_metadata_schema_ids
    self.lo_metadata_schemas.map(&:metadata_schema_id)
  end

  def metadata_general    
    MetadataSchema.general.joins(:lo_metadata_schemas)
                  .select("metadata_schemas.name, lo_metadata_schemas.id, lo_metadata_schemas.value")
                  .where(:id => lo_metadata_schema_ids, lo_metadata_schemas: { learning_object_id: self.id })
  end

  def metadata_life_cycle
    MetadataSchema.life_cycle.joins(:lo_metadata_schemas)
                  .select("metadata_schemas.name, lo_metadata_schemas.id, lo_metadata_schemas.value")
                  .where(:id => lo_metadata_schema_ids, lo_metadata_schemas: { learning_object_id: self.id })
  end

  def metadata_educational
    MetadataSchema.educational.joins(:lo_metadata_schemas)
                  .select("metadata_schemas.name, lo_metadata_schemas.id, lo_metadata_schemas.value")
                  .where(:id => lo_metadata_schema_ids, lo_metadata_schemas: { learning_object_id: self.id })
  end

  def metadata_rights
    MetadataSchema.rights.joins(:lo_metadata_schemas)
                  .select("metadata_schemas.name, lo_metadata_schemas.id, lo_metadata_schemas.value")
                  .where(:id => lo_metadata_schema_ids, lo_metadata_schemas: { learning_object_id: self.id })
  end
end
