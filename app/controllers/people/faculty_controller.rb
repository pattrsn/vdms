class FacultyController < PeopleController
  before_filter :get_areas_and_divisions, :only => [:new, :edit, :create, :update]

  # GET /people/faculty
  def index
    @faculty = Faculty.by_name
  end

  # GET /people/faculty/1/new
  def new
    @faculty_instance = (@current_user.new_record?) ? @current_user : Faculty.new
  end

  # GET /people/faculty/1/edit_availability
  def edit_availability
    settings = Settings.instance
    @faculty_instance = Faculty.find(params[:id])
    #@faculty_instance.build_time_slots(settings.meeting_times(@faculty_instance.division), settings.meeting_length, settings.meeting_gap)

    if Settings.instance.disable_faculty && @current_user.class == Faculty
      flash[:alert] = t('people.faculty.edit_availability.disabled')
    end

    @origin_action = 'edit_availability'
    @redirect_action = 'edit_availability'
  end

  # GET /people/faculty/1/rank_admits
  def rank_admits
    @faculty_instance = Faculty.find(params[:id])

    unless params[:select].nil?
      new_admits = Admit.find(params[:select].select {|admit, checked| checked.to_b}.map(&:first))
      new_admits.each {|a| @faculty_instance.rankings.build(:rankable => a, :rank => 1)}
    end

    if Settings.instance.disable_faculty && @current_user.class == Faculty
      flash[:alert] = t('people.faculty.rank_admits.disabled')
    elsif @faculty_instance.rankings.empty?
      redirect_to(select_admits_faculty_instance_url(@faculty_instance))
      return
    end

    @origin_action = 'rank_admits'
    @redirect_action = 'rank_admits'
  end

  # GET /people/faculty/1/select_admits
  def select_admits
    @faculty_instance = Faculty.find(params[:id])
    if params[:filter].nil?
      @areas = Settings.instance.areas.keys.sort!.map {|a| [a, true]}
      @admits = Admit.by_name
    else
      @areas = params[:filter].update_values(&:to_b).to_a.sort
      filter_areas = @areas.select {|area, checked| checked}.map(&:first)
      @admits = Admit.with_areas(*filter_areas)
    end
    @admits -= @faculty_instance.rankings.map(&:rankable)
  end

  private

  def get_model
    @model = Faculty
    @collection = 'faculty'
    @instance = 'faculty_instance'
  end

  def get_areas_and_divisions
    settings = Settings.instance
    @areas = settings.areas.map {|k, v| [v, k]}.sort!
    @divisions = settings.divisions.map {|k, v| [v, k]}.sort!
  end
end
