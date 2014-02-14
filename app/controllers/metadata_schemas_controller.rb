class MetadataSchemasController < ApplicationController
  # GET /metadata_schemas
  # GET /metadata_schemas.json
  def index
    @metadata_schemas = MetadataSchema.arrange(:order => :created_at)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @metadata_schemas }
    end
  end

  # GET /metadata_schemas/1
  # GET /metadata_schemas/1.json
  def show
    @metadata_schema = MetadataSchema.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @metadata_schema }
    end
  end

  # GET /metadata_schemas/new
  # GET /metadata_schemas/new.json
  def new
    @metadata_schema = MetadataSchema.new(:parent_id => params[:parent_id])

    respond_to do |format|
      format.html # new.html.erb
      format.js
      format.json { render json: @metadata_schema }
    end
  end

  # GET /metadata_schemas/1/edit
  def edit
    @metadata_schema = MetadataSchema.find(params[:id])
    respond_to do |format|
      format.js { render 'new.js'}
    end
  end

  # POST /metadata_schemas
  # POST /metadata_schemas.json
  def create
    @metadata_schema = MetadataSchema.new(params[:metadata_schema])

    respond_to do |format|
      if @metadata_schema.save
        @metadata_schemas = MetadataSchema.arrange(:order => :created_at)
        format.html { redirect_to @metadata_schema, notice: 'Metadata schema was successfully created.' }
        format.json { render json: @metadata_schema, status: :created, location: @metadata_schema }
        format.js
      else
        format.html { render action: "new" }
        format.json { render json: @metadata_schema.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /metadata_schemas/1
  # PUT /metadata_schemas/1.json
  def update
    @metadata_schema = MetadataSchema.find(params[:id])

    respond_to do |format|
      if @metadata_schema.update_attributes(params[:metadata_schema])
        @metadata_schemas = MetadataSchema.arrange(:order => :created_at)
        format.html { redirect_to @metadata_schema, notice: 'Metadata schema was successfully updated.' }
        format.json { head :no_content }
        format.js { render 'create.js'}
      else
        format.html { render action: "edit" }
        format.json { render json: @metadata_schema.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /metadata_schemas/1
  # DELETE /metadata_schemas/1.json
  def destroy
    @metadata_schema = MetadataSchema.find(params[:id])
    @metadata_schema.destroy

    respond_to do |format|
      @metadata_schemas = MetadataSchema.arrange(:order => :created_at)
      format.html { redirect_to metadata_schemas_url }
      format.json { head :no_content }
      format.js { render 'create.js'}
    end
  end
end
