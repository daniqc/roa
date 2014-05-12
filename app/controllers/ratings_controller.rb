#encoding: utf-8
class RatingsController < ApplicationController
  # GET /ratings
  # GET /ratings.json
  def index
    @learning_object = LearningObject.find(params[:learning_object_id])
    @ratings = @learning_object.ratings

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @ratings }
    end
  end

  # GET /ratings/1
  # GET /ratings/1.json
  def show
    @rating = Rating.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @rating }
    end
  end

  # GET /ratings/new
  # GET /ratings/new.json
  def new
    @learning_object = LearningObject.find(params[:learning_object_id])
    @rating = @learning_object.ratings.build

    # Reviso si el usuario actual puede evaluar el objeto (no puede evaluarlo dos veces)
    @can_evaluate = current_person.ratings.where(:learning_object_id => @learning_object.id).empty?
    

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @rating }
    end
  end

  # GET /ratings/1/edit
  def edit
    @rating = Rating.find(params[:id])
  end

  # POST /ratings
  # POST /ratings.json
  def create
    @rating = Rating.new(params[:rating])
    @rating.evaluation = params[:rating_star]
    learning_object = LearningObject.find(params[:learning_object_id])

    respond_to do |format|
      if @rating.save
        format.html { redirect_to learning_object_ratings_path, notice: 'El rating fue exitosamente agregado!' }
        format.json { render json: @rating, status: :created, location: @rating }
      else
        format.html { redirect_to new_learning_object_rating_path(learning_object), notice: 'Debes agregar tu evaluación con las estrellas! ' }
        format.json { render json: @rating.errors, status: :unprocessable_entity }
      end
    end

    # render :nothing => true
  end

  # PUT /ratings/1
  # PUT /ratings/1.json
  def update
    @rating = Rating.find(params[:id])

    respond_to do |format|
      if @rating.update_attributes(params[:rating])
        format.html { redirect_to @rating, notice: 'Rating was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @rating.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ratings/1
  # DELETE /ratings/1.json
  def destroy
    @rating = Rating.find(params[:id])
    @rating.destroy

    respond_to do |format|
      format.html { redirect_to ratings_url }
      format.json { head :no_content }
    end
  end
end
