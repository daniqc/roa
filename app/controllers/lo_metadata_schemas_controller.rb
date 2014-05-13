class LoMetadataSchemasController < ApplicationController
  before_filter :authorize
  # GET /lo_metadata_schemas
  # GET /lo_metadata_schemas.json
  def index
    @lo_metadata_schemas = LoMetadataSchema.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @lo_metadata_schemas }
    end
  end

  # GET /lo_metadata_schemas/1
  # GET /lo_metadata_schemas/1.json
  def show
    @lo_metadata_schema = LoMetadataSchema.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @lo_metadata_schema }
    end
  end

  # GET /lo_metadata_schemas/new
  # GET /lo_metadata_schemas/new.json
  def new
    @lo_metadata_schema = LoMetadataSchema.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @lo_metadata_schema }
    end
  end

  # GET /lo_metadata_schemas/1/edit
  def edit
    @lo_metadata_schema = LoMetadataSchema.find(params[:id])
  end

  # POST /lo_metadata_schemas
  # POST /lo_metadata_schemas.json
  def create
    @lo_metadata_schema = LoMetadataSchema.new(params[:lo_metadata_schema])

    respond_to do |format|
      if @lo_metadata_schema.save
        format.html { redirect_to @lo_metadata_schema, notice: 'Lo metadata schema was successfully created.' }
        format.json { render json: @lo_metadata_schema, status: :created, location: @lo_metadata_schema }
      else
        format.html { render action: "new" }
        format.json { render json: @lo_metadata_schema.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /lo_metadata_schemas/1
  # PUT /lo_metadata_schemas/1.json
  def update
    @lo_metadata_schema = LoMetadataSchema.find(params[:id])

    respond_to do |format|
      if @lo_metadata_schema.update_attributes(params[:lo_metadata_schema])
        format.html { redirect_to @lo_metadata_schema, notice: 'Lo metadata schema was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @lo_metadata_schema.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lo_metadata_schemas/1
  # DELETE /lo_metadata_schemas/1.json
  def destroy
    @lo_metadata_schema = LoMetadataSchema.find(params[:id])
    @lo_metadata_schema.destroy

    respond_to do |format|
      format.html { redirect_to lo_metadata_schemas_url }
      format.json { head :no_content }
    end
  end
end
