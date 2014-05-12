class ContentsController < ApplicationController
  # GET /contents
  # GET /contents.json
  def index
    @course = Course.find(params[:course_id])
    @contents = @course.contents.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @contents }
    end
  end

  # GET /contents/1
  # GET /contents/1.json
  def show
    @content = Content.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @content }
    end
  end

  # GET /contents/new
  # GET /contents/new.json
  def new
    @course = Course.find(params[:course_id])
    @content = content_type.new(:parent_id => params[:parent_id], :course_id => @course.id)
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @content }
    end
  end

  # GET /contents/1/edit
  def edit
    @content = Content.find(params[:id])
  end

  # POST /contents
  # POST /contents.json
  def create
    @course = Course.find(params[:course_id])
    @content = content_type.new(params[:content])

    respond_to do |format|
      if @content.save
        format.html { redirect_to @course, notice: 'El contenido fue exitosamente creado!' }
        format.json { render json: @course, status: :created, location: @course }
      else
        format.html { redirect_to new_course_topic_path(@course), notice: 'Debe agregar por lo menos el nombre del contenido para agregarlo.' }
        format.json { render json: @content.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /contents/1
  # PUT /contents/1.json
  def update
    @content = Content.find(params[:id])

    respond_to do |format|
      if @content.update_attributes(params[:content])
        format.html { redirect_to @content.course, notice: 'Content was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @content.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contents/1
  # DELETE /contents/1.json
  def destroy
    @content = Content.find(params[:id])
    @course = @content.course_id
    LearningMaterial.destroy_content(@content)
    @content.destroy

    respond_to do |format|
      format.html { redirect_to course_path(@course), notice: 'El tema ha sido exitosamente eliminado' }
      format.json { head :no_content }
    end
  end

  def content_type
    params[:type].constantize
  end
end
