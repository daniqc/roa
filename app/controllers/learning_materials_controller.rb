class LearningMaterialsController < ApplicationController
  # GET /learning_materials
  # GET /learning_materials.json
  def index
    @learning_materials = LearningMaterial.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @learning_materials }
    end
  end

  # GET /learning_materials/1
  # GET /learning_materials/1.json
  def show
    @learning_material = LearningMaterial.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @learning_material }
    end
  end

  # GET /learning_materials/new
  # GET /learning_materials/new.json
  def new
    @learning_material = LearningMaterial.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @learning_material }
    end
  end

  # GET /learning_materials/1/edit
  def edit
    @learning_material = LearningMaterial.find(params[:id])
  end

  # POST /learning_materials
  # POST /learning_materials.json
  def create
    @learning_material = LearningMaterial.new(params[:learning_material])

    respond_to do |format|
      if @learning_material.save
        format.html { redirect_to @learning_material, notice: 'Learning material was successfully created.' }
        format.json { render json: @learning_material, status: :created, location: @learning_material }
      else
        format.html { render action: "new" }
        format.json { render json: @learning_material.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /learning_materials/1
  # PUT /learning_materials/1.json
  def update
    @learning_material = LearningMaterial.find(params[:id])

    respond_to do |format|
      if @learning_material.update_attributes(params[:learning_material])
        format.html { redirect_to @learning_material, notice: 'Learning material was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @learning_material.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /learning_materials/1
  # DELETE /learning_materials/1.json
  def destroy
    @learning_material = LearningMaterial.find(params[:id])
    @learning_material.destroy

    respond_to do |format|
      format.html { redirect_to learning_materials_url }
      format.json { head :no_content }
    end
  end
end
