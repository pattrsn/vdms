ActionController::Routing::Routes.draw do |map|
  map.with_options :controller => 'root' do |root|
    root.home '', :action => 'home', :conditions => {:method => :get}
    root.sign_out 'sign_out', :action => 'sign_out', :conditions => {:method => :get}
    root.sign_out 'sign_out', :action => 'sign_out', :conditions => {:method => :delete}
    root.staff_dashboard 'staff', :action => 'staff_dashboard', :conditions => {:method => :get}
    root.peer_advisor_dashboard 'peer_advisor', :action => 'peer_advisor_dashboard', :conditions => {:method => :get}
    root.faculty_dashboard 'faculty', :action => 'faculty_dashboard', :conditions => {:method => :get}
  end

  map.resource :settings, :only => [:edit, :update]

  map.resources :staffs, :except => [:show], :collection => {:import => :get}, :member => {:delete => :get}, :path_prefix => '/people'
  map.resources :peer_advisors, :except => [:show], :collection => {:import => :get}, :member => {:delete => :get}, :path_prefix => '/people'
  map.resources :faculties, :except => [:show], :collection => {:import => :get}, :member => {:delete => :get}, :path_prefix => '/people'
  map.resources :admits, :except => [:show], :collection => {:import => :get}, :member => {:delete => :get}, :path_prefix => '/people'
end
