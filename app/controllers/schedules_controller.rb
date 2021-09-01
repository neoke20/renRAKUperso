class SchedulesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_kurasu, only: %i[index create new]
  add_breadcrumb "Dashboard", :dashboards_path
  add_breadcrumb "Classes", :kurasus_path
  add_breadcrumb "Schedules", :kurasu_schedules_path


  def index
    @user = current_user
    @schedules = policy_scope(Schedule)
  end

  def create
    @schedule = Schedule.new(schedule_params)
    authorize @schedule
    @schedule.kurasu = @kurasu
    if @schedule.save
      redirect_to kurasu_schedules_path(@kurasu)
      LineCreator.new("New class schedule was uploaded").send_line
    else
      render '/schedules/new'
    end
  end

  def new
    @schedule = Schedule.new
    authorize @schedule
  end

  def edit
    @schedule = Schedule.find(params[:id])
    authorize @schedule
  end

  def update
    @schedule = Schedule.find(params[:id])
    authorize @schedule
    @schedule.update(schedule_params)
    @schedule.kurasu = @schedule.kurasu
    if @schedule.save
      redirect_to kurasu_schedules_path(@schedule.kurasu)
    else
      render '/schedules/edit'
    end
  end

  private

  def find_kurasu
    @kurasu = Kurasu.find(params[:kurasu_id])
  end

  def schedule_params
    params.require(:schedule).permit(:photo, :kurasu_id)
  end

end
