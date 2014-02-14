class ClassSchedulesController < ApplicationController
  # GET /class_schedules
  # GET /class_schedules.json
  def index
    @class_schedules = ClassSchedule.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @class_schedules }
    end
  end

  # GET /class_schedules/1
  # GET /class_schedules/1.json
  def show
    @class_schedule = ClassSchedule.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @class_schedule }
    end
  end

  # GET /class_schedules/new
  # GET /class_schedules/new.json
  def new
    @class_schedule = ClassSchedule.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @class_schedule }
    end
  end

  # GET /class_schedules/1/edit
  def edit
    @class_schedule = ClassSchedule.find(params[:id])
  end

  # POST /class_schedules
  # POST /class_schedules.json
  def create
    @class_schedule = ClassSchedule.new(params[:class_schedule])

    respond_to do |format|
      if @class_schedule.save
        format.html { redirect_to @class_schedule, notice: 'Class schedule was successfully created.' }
        format.json { render json: @class_schedule, status: :created, location: @class_schedule }
      else
        format.html { render action: "new" }
        format.json { render json: @class_schedule.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /class_schedules/1
  # PUT /class_schedules/1.json
  def update
    @class_schedule = ClassSchedule.find(params[:id])

    respond_to do |format|
      if @class_schedule.update_attributes(params[:class_schedule])
        format.html { redirect_to @class_schedule, notice: 'Class schedule was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @class_schedule.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /class_schedules/1
  # DELETE /class_schedules/1.json
  def destroy
    @class_schedule = ClassSchedule.find(params[:id])
    @class_schedule.destroy

    respond_to do |format|
      format.html { redirect_to class_schedules_url }
      format.json { head :no_content }
    end
  end
end
