class MeetingsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_kurasu, only: %i[create new index]
  before_action :create_user, only: %i[index create]
  before_action :display_meetings, only: %i[index create]
  add_breadcrumb "Dashboard", :dashboards_path
  add_breadcrumb "Classes", :kurasus_path
  add_breadcrumb "Meetings", :kurasu_meetings_path

  def index
  end

  def show
  end

  def create
    new_meetings = meeting_creation
    new_meetings.each do |meeting|
      unless meeting.save
        render 'meetings/index'
        return nil
      end
    end
    # If all meetings save then reroute to:
    redirect_to kurasu_meetings_path
    # If even one meeting fails, go back to the create form
  end

  def new
    @meeting = Meeting.new
    authorize @meeting
  end

  def edit
    authorize @meeting
  end

  def update
    @meeting.parent = current_user
    authorize @meeting
  end

  private

  def find_kurasu
    @kurasu = Kurasu.find(params[:kurasu_id])
  end

  def meeting_creation
    new_meetings = []
    5.times do
      @meeting = Meeting.new(meeting_params)
      @meeting.teacher = current_user
      @meeting.kurasu = Kurasu.find(params[:kurasu_id])
      authorize @meeting
      new_meetings << @meeting
    end
    new_meetings
  end

  def meeting_params
    params.require(:meeting).permit(:title, :content, :date, :parent_id)
  end

  def find_meeting
    Meeting.find(params[:id]) # TODO: change this later
  end

  def display_meetings
    if @user.teacher
      @meetings = Meeting.where(current_user == :user)
      @meetings = policy_scope(Meeting)
      @meeting = Meeting.new
    else
      @meetings = Meeting.where(parent_id.nil?)
      @meetings = policy_scope(Meeting)
    end
  end

  def create_user
    @user = current_user
  end
end
