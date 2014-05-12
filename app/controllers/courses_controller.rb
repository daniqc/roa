class CoursesController < ApplicationController
  before_filter :authorize
  # GET /courses
  # GET /courses.json
  def index
    option = params[:option]
    @courses = Course.all

    respond_to do |format|
      if option == "2" # La opcion 2 corresponde a la administracion de cursos.
        format.html # index.html.erb
        format.json { render json: @courses }
      else #opcion 1 u otra
        # Corresponde a la visualizacion de los cursos y sus OA's asociados
        format.html { render 'index_common' }
      end
    end
  end

  # GET /courses/1
  # GET /courses/1.json
  def show
    @course = Course.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @course }
    end
  end

  # GET /courses/new
  # GET /courses/new.json
  def new
    @course = Course.new

    respond_to do |format|
      format.html # new.html.erb
      #format.js { render 'course.js'}
      format.json { render json: @course }
    end
  end

  # GET /courses/1/edit
  def edit
    @course = Course.find(params[:id])
  end

  # POST /courses
  # POST /courses.json
  def create
    @course = Course.new(params[:course])

    respond_to do |format|
      if @course.save
        format.html { redirect_to courses_path(), notice: 'El curso fue exitosamente creado.' }
        format.json { render json: @course, status: :created, location: @course }
      else
        format.html { redirect_to new_course_path, notice: "Debe escribir por lo menos el nombre del curso para crearlo." }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /courses/1
  # PUT /courses/1.json
  def update
    @course = Course.find(params[:id])

    respond_to do |format|
      if @course.update_attributes(params[:course])
        format.html { redirect_to courses_path(:option=>2), notice: 'El curso fue exitosamente editado!' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1
  # DELETE /courses/1.json
  def destroy
    @course = Course.find(params[:id])
    LearningMaterial.destroy_course(@course)
    @course.destroy

    respond_to do |format|
      format.html { redirect_to courses_path(:option=>2), notice: 'El curso fue exitosamente eliminado!'  }
      format.json { head :no_content }
    end
  end

  def course_organization
    # render :nothing => true
    @course = Course.find(params[:id])
    respond_to do |format|
      format.html 
      format.json { render json: @course }
    end
  end
end
