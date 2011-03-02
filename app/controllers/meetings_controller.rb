class MeetingsController < ApplicationController
  
  before_filter :current_user_is_staff?, :only => [:tweak, :apply_tweaks, :create_all]
  before_filter :schedule_empty?

  # GET /meetings/
  # If called with a faculty_id, show that faculty's meetings
  # If called with an admit_id, show that admit's meetings
  # If neither, show the master schedule of meetings
  def index
    params[:faculty_id] ? for_faculty(params[:faculty_id]) :
      params[:admit_id] ? for_admit(params[:admit_id]) :
      master
  end

  # Show the master schedule
  # GET /meetings/master
  def master
    meetings = Meeting.all
    @meetings_by_faculty = meetings.group_by(&:faculty)
    @times = meetings.map(&:time).uniq.sort
  end

  # Show schedule for admit
  # GET /people/admits/1/meetings

  def for_admit(admit_id)
    @admit = Admit.find(admit_id)
    @admit_meetings = @admit.meetings.sort_by(&:time)
    render :action => 'for_admit'
  end

  # Show schedule for faculty
  # GET /people/faculty/1/meetings
  def for_faculty(faculty_id)
    @faculty = Faculty.find(faculty_id)
    @faculty_meetings = @faculty.meetings.sort_by(&:time)
    render :action => 'for_faculty'
  end

  # Tweak the schedule for faculty (ie, show editable view) - for staff only
  def tweak
    @faculty = Faculty.find(params[:faculty_id])
    @max_admits = @faculty.max_admits_per_meeting
    @meetings = @faculty.meetings.sort_by(&:time)
    @all_admits = Admit.all.sort_by(&:last_name)
  end

  # Save the tweaks to a faculty meeting schedule - for staff only
  def apply_tweaks
    flash[:notice] = ''
    params.delete_if { |k,v| v.blank? }
    messages = delete_meetings(params.keys)
    messages += add_meetings(params.keys)
    flash[:notice] = messages.join('<br/>')
    redirect_to master_meetings_path
  end
  
  # Run the scheduler
  # POST /meetings/create_all
  def create_all
    begin
      Meeting.generate()
      flash[:notice] = "New schedule successfully generated."
    rescue Exception => e
      flash[:notice] = "New schedule could NOT be generated: #{e.message}"
    end
    redirect_to master_meetings_path
  end

  private

  def delete_meetings(keys)
    messages = []
    keys.each do |key|
      if key =~ /^remove_(\d+)_(\d+)$/
        begin
          admit = Admit.find($1)
          meeting = Meeting.find($2)
          meeting.admits -= [admit]
          meeting.save!
          messages << "#{admit.full_name} removed from #{meeting.time.strftime('%l:%M')} meeting."
        rescue Exception => e
          messages << "Can't remove admit #{admit.full_name} from meeting #{meeting}: #{e.message}"
        end
      end
    end
    messages
  end

  def add_meetings(keys)
    messages = []
  end

  def current_user_is_staff?
    unless @current_user && @current_user.class.name == 'Staff'
      flash[:notice] = 'Only Staff users may perform this action.'
      redirect_to home_path
    end
  end

  def schedule_empty?
    if Meeting.count.zero?
      flash[:notice] = t('meetings.master.if_empty')
    end
    true
  end
end
