class ResourceFilesController < ApplicationController
  # GET /resource_files
  # GET /resource_files.json
  def index
    @resource_files = ResourceFile.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @resource_files }
    end
  end

  # GET /resource_files/1
  # GET /resource_files/1.json
  def show
    @resource_file = ResourceFile.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @resource_file }
    end
  end

  # GET /resource_files/new
  # GET /resource_files/new.json
  def new
    @resource_file = ResourceFile.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @resource_file }
    end
  end

  # GET /resource_files/1/edit
  def edit
    @resource_file = ResourceFile.find(params[:id])
  end

  # POST /resource_files
  # POST /resource_files.json
  def create
    @resource_file = ResourceFile.new(params[:resource_file])

    respond_to do |format|
      if @resource_file.save
        format.html { redirect_to @resource_file, notice: 'Resource file was successfully created.' }
        format.json { render json: @resource_file, status: :created, location: @resource_file }
      else
        format.html { render action: "new" }
        format.json { render json: @resource_file.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /resource_files/1
  # PUT /resource_files/1.json
  def update
    @resource_file = ResourceFile.find(params[:id])

    respond_to do |format|
      if @resource_file.update_attributes(params[:resource_file])
        format.html { redirect_to @resource_file, notice: 'Resource file was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @resource_file.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /resource_files/1
  # DELETE /resource_files/1.json
  def destroy
    @resource_file = ResourceFile.find(params[:id])
    @resource_file.destroy

    respond_to do |format|
      format.html { redirect_to resource_files_url }
      format.json { head :no_content }
    end
  end
end
