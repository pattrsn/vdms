require 'spec_helper'

describe 'Routes' do
  context 'Home' do
    it 'routes GET / to Root#index' do
      {:get => '/'}.should route_to(:controller => 'root', :action => 'home')
    end
  end

  context 'Sign Out' do
    it 'routes GET /sign_out to Root#sign_out' do
      {:get => '/sign_out'}.should route_to(:controller => 'root', :action => 'sign_out')
    end

    it 'routes DELETE /sign_out to Root#sign_out' do
      {:delete => '/sign_out'}.should route_to(:controller => 'root', :action => 'sign_out')
    end
  end

  context 'Staff Dashboard' do
    it 'routes GET /staff to Root#staff_dashboard' do
      {:get => '/staff'}.should route_to(:controller => 'root', :action => 'staff_dashboard')
    end
  end

  context 'Peer Advisor Dashboard' do
    it 'routes GET /peer_advisor to Root#peer_advisor_dashboard' do
      {:get => '/peer_advisor'}.should route_to(:controller => 'root', :action => 'peer_advisor_dashboard')
    end
  end

  context 'Faculty Dashboard' do
    it 'routes GET /faculty to Root#faculty_dashboard' do
      {:get => '/faculty'}.should route_to(:controller => 'root', :action => 'faculty_dashboard')
    end
  end

  context 'Settings' do
    context 'Update Settings' do
      it 'routes GET /settings/edit do Settings#edit' do
        {:get => '/settings/edit'}.should route_to(:controller => 'settings', :action => 'edit')
      end

      it 'routes PUT /settings to Settings#update' do
        {:put => '/settings'}.should route_to(:controller => 'settings', :action => 'update')
      end
    end
  end

  context 'People' do
    context 'Staff' do
      context 'View Staff' do
        it 'routes GET /people/staff to Staff#index' do
          {:get => '/people/staff'}.should route_to(:controller => 'staff', :action => 'index')
        end
      end

      context 'Remove All Staff' do
        it 'routes GET /people/staff/delete_all to Staff#delete_all' do
          {:get => '/people/staff/delete_all'}.should route_to(:controller => 'staff', :action => 'delete_all')
        end

        it 'routes DELETE /people/staff/destroy_all to Staff#destroy_all' do
          {:delete => '/people/staff/destroy_all'}.should route_to(:controller => 'staff', :action => 'destroy_all')
        end
      end

      context 'Add Staff' do
        it 'routes GET /people/staff/new to Staff#new' do
          {:get => '/people/staff/new'}.should route_to(:controller => 'staff', :action => 'new')
        end

        it 'routes POST /people/staff to Staff#create' do
          {:post => '/people/staff'}.should route_to(:controller => 'staff', :action => 'create')
        end
      end

      context 'Import Staff' do
        it 'routes GET /people/staff/upload to Staff#upload' do
          {:get => '/people/staff/upload'}.should route_to(:controller => 'staff', :action => 'upload')
        end

        it 'routes POST /people/staff/import to Staff#import' do
          {:post => '/people/staff/import'}.should route_to(:controller => 'staff', :action => 'import')
        end
      end

      context 'Update Staff' do
        it 'routes GET /people/staff/1/edit to Staff#edit' do
          {:get => '/people/staff/1/edit'}.should route_to(:controller => 'staff', :action => 'edit', :id => '1')
        end

        it 'routes PUT /people/staff/1 to Staff#update' do
          {:put => '/people/staff/1'}.should route_to(:controller => 'staff', :action => 'update', :id => '1')
        end
      end

      context 'Remove Staff' do
        it 'routes GET /people/staff/1/delete to Staff#delete' do
          {:get => '/people/staff/1/delete'}.should route_to(:controller => 'staff', :action => 'delete', :id => '1')
        end

        it 'routes DELETE /people/staff/1 to Staff#destroy' do
          {:delete => '/people/staff/1'}.should route_to(:controller => 'staff', :action => 'destroy', :id => '1')
        end
      end
    end

    context 'Peer Advisors' do
      context 'View Peer Advisors' do
        it 'routes GET /people/peer_advisors to PeerAdvisors#index' do
          {:get => '/people/peer_advisors'}.should route_to(:controller => 'peer_advisors', :action => 'index')
        end
      end

      context 'Remove All Peer Advisors' do
        it 'routes GET /people/peer_advisors/delete_all to PeerAdvisors#delete_all' do
          {:get => '/people/peer_advisors/delete_all'}.should route_to(:controller => 'peer_advisors', :action => 'delete_all')
        end

        it 'routes DELETE /people/peer_advisors/destroy_all to PeerAdvisors#destroy_all' do
          {:delete => '/people/peer_advisors/destroy_all'}.should route_to(:controller => 'peer_advisors', :action => 'destroy_all')
        end
      end

      context 'Add Peer Advisors' do
        it 'routes GET /people/peer_advisors/new to PeerAdvisors#new' do
          {:get => '/people/peer_advisors/new'}.should route_to(:controller => 'peer_advisors', :action => 'new')
        end

        it 'routes POST /people/peer_advisors to PeerAdvisors#create' do
          {:post => '/people/peer_advisors'}.should route_to(:controller => 'peer_advisors', :action => 'create')
        end
      end

      context 'Import Peer Advisors' do
        it 'routes GET /people/peer_advisors/upload to PeerAdvisors#upload' do
          {:get => '/people/peer_advisors/upload'}.should route_to(:controller => 'peer_advisors', :action => 'upload')
        end

        it 'routes POST /people/peer_advisors/import to PeerAdvisors#import' do
          {:post => '/people/peer_advisors/import'}.should route_to(:controller => 'peer_advisors', :action => 'import')
        end
      end

      context 'Update Peer Advisors' do
        it 'routes GET /people/peer_advisors/1/edit to PeerAdvisors#edit' do
          {:get => '/people/peer_advisors/1/edit'}.should route_to(:controller => 'peer_advisors', :action => 'edit', :id => '1')
        end

        it 'routes PUT /people/peer_advisors/1 to PeerAdvisors#update' do
          {:put => '/people/peer_advisors/1'}.should route_to(:controller => 'peer_advisors', :action => 'update', :id => '1')
        end
      end

      context 'Remove Peer Advisors' do
        it 'routes GET /people/peer_advisors/1/delete to PeerAdvisors#delete' do
          {:get => '/people/peer_advisors/1/delete'}.should route_to(:controller => 'peer_advisors', :action => 'delete', :id => '1')
        end

        it 'routes DELETE /people/peer_advisors/1 to PeerAdvisors#destroy' do
          {:delete => '/people/peer_advisors/1'}.should route_to(:controller => 'peer_advisors', :action => 'destroy', :id => '1')
        end
      end
    end

    context 'Faculty' do
      context 'View Faculty' do
        it 'routes GET /people/faculty to Faculty#index' do
          {:get => '/people/faculty'}.should route_to(:controller => 'faculty', :action => 'index')
        end
      end

      context 'Remove All Faculty' do
        it 'routes GET /people/faculty/delete_all to Faculty#delete_all' do
          {:get => '/people/faculty/delete_all'}.should route_to(:controller => 'faculty', :action => 'delete_all')
        end

        it 'routes DELETE /people/faculty/destroy_all to Faculty#destroy_all' do
          {:delete => '/people/faculty/destroy_all'}.should route_to(:controller => 'faculty', :action => 'destroy_all')
        end
      end

      context 'Add Faculty' do
        it 'routes GET /people/faculty/new to Faculty#new' do
          {:get => '/people/faculty/new'}.should route_to(:controller => 'faculty', :action => 'new')
        end

        it 'routes POST /people/faculty to Faculty#create' do
          {:post => '/people/faculty'}.should route_to(:controller => 'faculty', :action => 'create')
        end
      end

      context 'Import Faculty' do
        it 'routes GET /people/faculty/upload to Faculty#upload' do
          {:get => '/people/faculty/upload'}.should route_to(:controller => 'faculty', :action => 'upload')
        end

        it 'routes POST /people/faculty/import to Faculty#import' do
          {:post => '/people/faculty/import'}.should route_to(:controller => 'faculty', :action => 'import')
        end
      end

      context 'Update Faculty' do
        it 'routes GET /people/faculty/1/edit to Faculty#edit' do
          {:get => '/people/faculty/1/edit'}.should route_to(:controller => 'faculty', :action => 'edit', :id => '1')
        end

        it 'routes PUT /people/faculty/1 to Faculty#update' do
          {:put => '/people/faculty/1'}.should route_to(:controller => 'faculty', :action => 'update', :id => '1')
        end
      end

      context 'Remove Faculty' do
        it 'routes GET /people/faculty/1/delete to Faculty#delete' do
          {:get => '/people/faculty/1/delete'}.should route_to(:controller => 'faculty', :action => 'delete', :id => '1')
        end

        it 'routes DELETE /people/faculty/1 to Faculty#destroy' do
          {:delete => '/people/faculty/1'}.should route_to(:controller => 'faculty', :action => 'destroy', :id => '1')
        end
      end
    end

    context 'Admits' do
      context 'View Admits' do
        it 'routes GET /people/admits to Admits#index' do
          {:get => '/people/admits'}.should route_to(:controller => 'admits', :action => 'index')
        end
      end

      context 'Remove All Admits' do
        it 'routes GET /people/admits/delete_all to Admits#delete_all' do
          {:get => '/people/admits/delete_all'}.should route_to(:controller => 'admits', :action => 'delete_all')
        end

        it 'routes DELETE /people/admits/destroy_all to Admits#destroy_all' do
          {:delete => '/people/admits/destroy_all'}.should route_to(:controller => 'admits', :action => 'destroy_all')
        end
      end

      context 'Add Admits' do
        it 'routes GET /people/admits/new to Admits#new' do
          {:get => '/people/admits/new'}.should route_to(:controller => 'admits', :action => 'new')
        end

        it 'routes POST /people/admits to Admits#create' do
          {:post => '/people/admits'}.should route_to(:controller => 'admits', :action => 'create')
        end
      end

      context 'Import Admits' do
        it 'routes GET /people/admits/upload to Admits#upload' do
          {:get => '/people/admits/upload'}.should route_to(:controller => 'admits', :action => 'upload')
        end

        it 'routes POST /people/admits/import to Admits#import' do
          {:post => '/people/admits/import'}.should route_to(:controller => 'admits', :action => 'import')
        end
      end

      context 'Update Admits' do
        it 'routes GET /people/admits/1/edit to Admits#edit' do
          {:get => '/people/admits/1/edit'}.should route_to(:controller => 'admits', :action => 'edit', :id => '1')
        end

        it 'routes PUT /people/admits/1 to Admits#update' do
          {:put => '/people/admits/1'}.should route_to(:controller => 'admits', :action => 'update', :id => '1')
        end
      end

      context 'Remove Admits' do
        it 'routes GET /people/admits/1/delete to Admits#delete' do
          {:get => '/people/admits/1/delete'}.should route_to(:controller => 'admits', :action => 'delete', :id => '1')
        end

        it 'routes DELETE /people/admits/1 to Admits#destroy' do
          {:delete => '/people/admits/1'}.should route_to(:controller => 'admits', :action => 'destroy', :id => '1')
        end
      end
    end
  end


  describe 'Events' do
    describe 'Hosts' do
      describe 'Rankings' do
        context 'when adding' do
          it 'routes GET /hosts/1/rankings/add to HostRankings#add' do
            {:get => '/hosts/1/rankings/add'}.should route_to(:controller => 'host_rankings', :action => 'add', :host_id => '1')
          end
        end
        context 'when updating' do
          it 'routes GET /hosts/1/rankings/edit_all to HostRankings#edit_all' do
            {:get => '/hosts/1/rankings/edit_all'}.should route_to(:controller => 'host_rankings', :action => 'edit_all', :host_id => '1')
          end
          it 'routes PUT /hosts/1/rankings/update_all to HostRankings#update_all' do
            {:put => '/hosts/1/rankings/update_all'}.should route_to(:controller => 'host_rankings', :action => 'update_all', :host_id => '1')
          end
        end
      end
      describe 'Availabilities' do
        context 'when updating' do
          it 'routes GET /hosts/1/availabilities/edit_all to HostAvailabilities#edit_all' do
            {:get => '/hosts/1/availabilities/edit_all'}.should route_to(:controller => 'host_availabilities', :action => 'edit_all', :host_id => '1')
          end
          it 'routes PUT /hosts/1/availabilities/update_all to HostAvailabilities#update_all' do
            {:put => '/hosts/1/availabilities/update_all'}.should route_to(:controller => 'host_availabilities', :action => 'update_all', :host_id => '1')
          end
        end
      end
      describe 'Meetings' do
        context 'when viewing' do
          it 'routes GET /hosts/1/meetings to Meetings#index' do
            {:get => '/hosts/1/meetings'}.should route_to(:controller => 'meetings', :action => 'index', :host_id => '1')
          end
        end
        context 'when updating' do
          it 'routes GET /hosts/1/meetings/tweak to Meetings#tweak' do
            {:get => '/hosts/1/meetings/tweak'}.should route_to(:controller => 'meetings', :action => 'tweak', :host_id => '1')
          end
          it 'routes POST /hosts/1/meetings/apply_tweaks to Meetings#apply_tweaks' do
            {:post => '/hosts/1/meetings/apply_tweaks'}.should route_to(:controller => 'meetings', :action => 'apply_tweaks', :host_id => '1')
          end
        end
      end
    end
    describe 'Visitors' do
      describe 'Rankings' do
        context 'when adding' do
          it 'routes GET /visitors/1/rankings/add to VisitorRankings#add' do
            {:get => '/visitors/1/rankings/add'}.should route_to(:controller => 'visitor_rankings', :action => 'add', :visitor_id => '1')
          end
        end
        context 'when updating' do
          it 'routes GET /visitors/1/rankings/edit_all to VisitorRankings#edit_all' do
            {:get => '/visitors/1/rankings/edit_all'}.should route_to(:controller => 'visitor_rankings', :action => 'edit_all', :visitor_id => '1')
          end
          it 'routes PUT /visitors/1/rankings/update_all to VisitorRankings#update_all' do
            {:put => '/visitors/1/rankings/update_all'}.should route_to(:controller => 'visitor_rankings', :action => 'update_all', :visitor_id => '1')
          end
        end
      end
      describe 'Availabilities' do
        context 'when updating' do
          it 'routes GET /visitors/1/availabilities/edit_all to VisitorAvailabilities#edit_all' do
            {:get => '/visitors/1/availabilities/edit_all'}.should route_to(:controller => 'visitor_availabilities', :action => 'edit_all', :visitor_id => '1')
          end
          it 'routes PUT /visitors/1/availabilities/update_all to VisitorAvailabilities#update_all' do
            {:put => '/visitors/1/availabilities/update_all'}.should route_to(:controller => 'visitor_availabilities', :action => 'update_all', :visitor_id => '1')
          end
        end
      end
      describe 'Meetings' do
        context 'when viewing' do
          it 'routes GET /visitors/1/meetings to Meetings#index' do
            {:get => '/visitors/1/meetings'}.should route_to(:controller => 'meetings', :action => 'index', :visitor_id => '1')
          end
        end
      end
    end
  end
end
