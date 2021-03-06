class PeopleController < ApplicationController
  before_filter :authorize
  # layout "authentication"
  # GET /people
  # GET /people.json
  def index
    @people = Person.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @people }
    end
    authorize! :read, Person
  end

  # # GET /people/1
  # # GET /people/1.json
  # def show
  #   @person = Person.find(params[:id])

  #   respond_to do |format|
  #     format.html # show.html.erb
  #     format.json { render json: @person }
  #   end
  # end

  # GET /people/new
  # GET /people/new.json
  def new
    @person = Person.new
    @person.build_user
    authorize! :new, Person
  end

  # POST /people
  # POST /people.json
  def create
    @person = Person.new(params[:person])
    #@person

    if @person.save
      session[:user_id] = @person.user.id
      redirect_to root_url, notice: "Thank you for signing up!"
    else
      render "new"
    end
    authorize! :create, Person
  end

  # # GET /people/1/edit
   def edit
     @person = Person.find(params[:id])
     authorize! :edit, Person
   end

  # # PUT /people/1
  # # PUT /people/1.json
  def update
    @person = Person.find(params[:id])

    respond_to do |format|
      if @person.update_attributes(params[:person])
        format.html { redirect_to root_url, notice: 'Person was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
    authorize! :update, Person
  end

  # # DELETE /people/1
  # # DELETE /people/1.json
  # def destroy
  #   @person = Person.find(params[:id])
  #   @person.destroy

  #   respond_to do |format|
  #     format.html { redirect_to people_url }
  #     format.json { head :no_content }
  #   end
  # end
end
