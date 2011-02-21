class PeerAdvisorsController < PeopleController
  # GET /people/peer_advisors/1/new
  def new
    @peer_advisor = (@current_user.new_record?) ? @current_user : PeerAdvisor.new
  end

  # POST /people/peer_advisors
  def create
    @peer_advisor = PeerAdvisor.new(params[:peer_advisor])
    @peer_advisor.ldap_id = @current_user.ldap_id if @current_user.new_record?

    if @peer_advisor.save
      redirect_to(peer_advisors_url, :notice => t(:success, :scope => [:people, :peer_advisors, :create]))
    else
      render :action => 'new'
    end
  end

  private

  def get_model
    @model = PeerAdvisor
    @collection = 'peer_advisors'
    @instance = 'peer_advisor'
  end
end
