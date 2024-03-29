require 'spec_helper'

describe PeerAdvisorsController do
  before(:each) do
    @staff = Factory.create(:staff)
    @peer_advisor = Factory.create(:peer_advisor)
  end

  describe 'GET index' do
    context 'when not signed in' do
      it 'redirects to the CalNet sign in page' do
        get :index
        response.should redirect_to("#{CASClient::Frameworks::Rails::Filter.config[:login_url]}?service=#{CGI.escape(peer_advisors_url)}")
      end
    end

    context 'when signed in as a Staff' do
      before(:each) do
        CASClient::Frameworks::Rails::Filter.fake(@staff.ldap_id)
      end

      it 'assigns to @peer_advisors a list of all the Peer Advisors sorted by last and first name' do
        peer_advisors = Array.new(3) {PeerAdvisor.new}
        PeerAdvisor.stub(:by_name).and_return(peer_advisors)
        get :index
        assigns[:peer_advisors].should == peer_advisors
      end

      it 'renders the index template' do
        get :index
        response.should render_template('index')
      end
    end

    context 'when signed in as a registered Peer Advisor'

    context 'when signed in as an unregistered Peer Advisor' do
      before(:each) do
        CASClient::Frameworks::Rails::Filter.fake('12345')
        Person.stub(:find).and_return(PeerAdvisor.new)
      end

      it 'redirects to the New Peer Advisor page' do
        get :index
        response.should redirect_to(:controller => 'peer_advisors', :action => 'new')
      end
    end

    context 'when signed in as a registered Faculty'

    context 'when signed in as an unregistered Faculty' do
      before(:each) do
        CASClient::Frameworks::Rails::Filter.fake('12345')
        Person.stub(:find).and_return(Faculty.new)
      end

      it 'redirects to the New Faculty page' do
        get :index
        response.should redirect_to(:controller => 'faculty', :action => 'new')
      end
    end
  end

  describe 'GET delete_all' do
    context 'when not signed in' do
      it 'redirects to the CalNet sign in page' do
        get :delete_all
        response.should redirect_to("#{CASClient::Frameworks::Rails::Filter.config[:login_url]}?service=#{CGI.escape(delete_all_peer_advisors_url)}")
      end
    end

    context 'when signed in as a Staff' do
      before(:each) do
        CASClient::Frameworks::Rails::Filter.fake(@staff.ldap_id)
      end

      it 'renders the delete_all template' do
        get :delete_all
        response.should render_template('delete_all')
      end
    end

    context 'when signed in as a registered Peer Advisor'

    context 'when signed in as an unregistered Peer Advisor' do
      before(:each) do
        CASClient::Frameworks::Rails::Filter.fake('12345')
        Person.stub(:find).and_return(PeerAdvisor.new)
      end

      it 'redirects to the New Peer Advisor page' do
        get :delete_all
        response.should redirect_to(:controller => 'peer_advisors', :action => 'new')
      end
    end

    context 'when signed in as a registered Faculty'

    context 'when signed in as an unregistered Faculty' do
      before(:each) do
        CASClient::Frameworks::Rails::Filter.fake('12345')
        Person.stub(:find).and_return(Faculty.new)
      end

      it 'redirects to the New Faculty page' do
        get :delete_all
        response.should redirect_to(:controller => 'faculty', :action => 'new')
      end
    end
  end

  describe 'GET new' do
    context 'when not signed in' do
      it 'redirects to the CalNet sign in page' do
        get :new
        response.should redirect_to("#{CASClient::Frameworks::Rails::Filter.config[:login_url]}?service=#{CGI.escape(new_peer_advisor_url)}")
      end
    end

    context 'when signed in as a Staff' do
      before(:each) do
        CASClient::Frameworks::Rails::Filter.fake(@staff.ldap_id)
      end

      it 'assigns to @peer_advisor a new Peer Advisor' do
        get :new
        assigns[:peer_advisor].should be_a_new_record
      end

      it 'renders the new template' do
        get :new
        response.should render_template('new')
      end
    end

    context 'when signed in as a registered Peer Advisor'

    context 'when signed in as an unregistered Peer Advisor' do
      before(:each) do
        CASClient::Frameworks::Rails::Filter.fake('12345')
        Person.stub(:find).and_return(PeerAdvisor.new)
      end

      it 'renders the new template' do
        get :new
        response.should render_template('new')
      end
    end

    context 'when signed in as a registered Faculty'

    context 'when signed in as an unregistered Faculty' do
      before(:each) do
        CASClient::Frameworks::Rails::Filter.fake('12345')
        Person.stub(:find).and_return(Faculty.new)
      end

      it 'redirects to the New Faculty page' do
        get :index
        response.should redirect_to(:controller => 'faculty', :action => 'new')
      end
    end
  end

  describe 'GET upload' do
    context 'when not signed in' do
      it 'redirects to the CalNet sign in page' do
        get :upload
        response.should redirect_to("#{CASClient::Frameworks::Rails::Filter.config[:login_url]}?service=#{CGI.escape(upload_peer_advisors_url)}")
      end
    end

    context 'when signed in as a Staff' do
      before(:each) do
        CASClient::Frameworks::Rails::Filter.fake(@staff.ldap_id)
      end

      it 'renders the upload template' do
        get :upload
        response.should render_template('upload')
      end
    end

    context 'when signed in as a registered Peer Advisor'

    context 'when signed in as an unregistered Peer Advisor' do
      before(:each) do
        CASClient::Frameworks::Rails::Filter.fake('12345')
        Person.stub(:find).and_return(PeerAdvisor.new)
      end

      it 'redirects to the New Peer Advisor page' do
        get :upload
        response.should redirect_to(:controller => 'peer_advisors', :action => 'new')
      end
    end

    context 'when signed in as a registered Faculty'

    context 'when signed in as an unregistered Faculty' do
      before(:each) do
        CASClient::Frameworks::Rails::Filter.fake('12345')
        Person.stub(:find).and_return(Faculty.new)
      end

      it 'redirects to the New Faculty page' do
        get :upload
        response.should redirect_to(:controller => 'faculty', :action => 'new')
      end
    end
  end

  describe 'GET edit' do
    context 'when not signed in' do
      it 'redirects to the CalNet sign in page' do
        get :edit, :id => @peer_advisor.id
        response.should redirect_to("#{CASClient::Frameworks::Rails::Filter.config[:login_url]}?service=#{CGI.escape(edit_peer_advisor_url(@peer_advisor.id))}")
      end
    end

    context 'when signed in as a Staff' do
      before(:each) do
        CASClient::Frameworks::Rails::Filter.fake(@staff.ldap_id)
      end
  
      it 'assigns to @peer_advisor the given Peer Advisor' do
        PeerAdvisor.stub(:find).and_return(@peer_advisor)
        get :edit, :id => @peer_advisor.id
        assigns[:peer_advisor].should == @peer_advisor
      end

      it 'sets the error redirect to the edit action' do
        get :edit, :id => @peer_advisor.id
        assigns[:origin_action].should == 'edit'
      end

      it 'sets the success redirect to the index action' do
        get :edit, :id => @peer_advisor.id
        assigns[:redirect_action].should == 'index'
      end

      it 'renders the edit template' do
        get :edit, :id => @peer_advisor.id
        response.should render_template('edit')
      end
    end

    context 'when signed in as a registered Peer Advisor'

    context 'when signed in as an unregistered Peer Advisor' do
      before(:each) do
        CASClient::Frameworks::Rails::Filter.fake('12345')
        LDAP.stub(:find_person).and_return(:role => :grad)
      end

      it 'redirects to the New Peer Advisor page' do
        get :edit, :id => @peer_advisor.id
        response.should redirect_to(:controller => 'peer_advisors', :action => 'new')
      end
    end

    context 'when signed in as a registered Faculty'

    context 'when signed in as an unregistered Faculty' do
      before(:each) do
        CASClient::Frameworks::Rails::Filter.fake('12345')
        LDAP.stub(:find_person).and_return(:role => :faculty)
      end

      it 'redirects to the New Faculty page' do
        get :edit, :id => @peer_advisor.id
        response.should redirect_to(:controller => 'faculty', :action => 'new')
      end
    end
  end

  describe 'GET delete' do
    context 'when not signed in' do
      it 'redirects to the CalNet sign in page' do
        get :delete, :id => @peer_advisor.id
        response.should redirect_to("#{CASClient::Frameworks::Rails::Filter.config[:login_url]}?service=#{CGI.escape(delete_peer_advisor_url(@peer_advisor.id))}")
      end
    end

    context 'when signed in as a Staff' do
      before(:each) do
        CASClient::Frameworks::Rails::Filter.fake(@staff.ldap_id)
      end

      it 'assigns to @peer_advisor the given Peer Advisor' do
        PeerAdvisor.stub(:find).and_return(@peer_advisor)
        get :delete, :id => @peer_advisor.id
        assigns[:peer_advisor].should == @peer_advisor
      end
 
      it 'renders the delete template' do
        get :delete, :id => @peer_advisor.id
        response.should render_template('delete')
      end
    end

    context 'when signed in as a registered Peer Advisor'

    context 'when signed in as an unregistered Peer Advisor' do
      before(:each) do
        CASClient::Frameworks::Rails::Filter.fake('12345')
        LDAP.stub(:find_person).and_return(:role => :grad)
      end

      it 'redirects to the New Peer Advisor page' do
        get :delete, :id => @peer_advisor.id
        response.should redirect_to(:controller => 'peer_advisors', :action => 'new')
      end
    end

    context 'when signed in as a registered Faculty'

    context 'when signed in as an unregistered Faculty' do
      before(:each) do
        CASClient::Frameworks::Rails::Filter.fake('12345')
        LDAP.stub(:find_person).and_return(:role => :faculty)
      end

      it 'redirects to the New Faculty page' do
        get :delete, :id => @peer_advisor.id
        response.should redirect_to(:controller => 'faculty', :action => 'new')
      end
    end
  end

  describe 'POST create' do
    context 'when not signed in' do
      it 'redirects to the CalNet sign in page' do
        post :create
        response.should redirect_to("#{CASClient::Frameworks::Rails::Filter.config[:login_url]}?service=#{CGI.escape(peer_advisors_url)}")
      end
    end

    context 'when signed in as a Staff' do
      before(:each) do
        PeerAdvisor.stub(:new).and_return(@peer_advisor)
        CASClient::Frameworks::Rails::Filter.fake(@staff.ldap_id)
      end

      it 'assigns to @peer_advisor a new Peer Advisor with the given parameters' do
        PeerAdvisor.should_receive(:new).with('foo' => 'bar').and_return(@peer_advisor)
        post :create, :peer_advisor => {'foo' => 'bar'}
        assigns[:peer_advisor].should equal(@peer_advisor)
      end
 
      it 'saves the PeerAdvisor' do
        @peer_advisor.should_receive(:save)
        post :create
      end

      context 'when the Peer Advisor is successfully saved' do
        before(:each) do
          @peer_advisor.stub(:save).and_return(true)
        end

        it 'sets a flash[:notice] message' do
          post :create
          flash[:notice].should == I18n.t('people.peer_advisors.create.success')
        end

        it 'redirects to the View Peer Advisors page' do
          post :create
          response.should redirect_to(:controller => 'peer_advisors', :action => 'index')
        end
      end

      context 'when the Peer Advisor fails to be saved' do
        before(:each) do
          @peer_advisor.stub(:save).and_return(false)
        end

        it 'renders the new template' do
          post :create
          response.should render_template('new')
        end
      end
    end

    context 'when signed in as a registered Peer Advisor'

    context 'when signed in as an unregistered Peer Advisor' do
      before(:each) do
        CASClient::Frameworks::Rails::Filter.fake('12345')
        LDAP.stub(:find_person).and_return(:role => :grad, :uid => '12345')
      end

      it 'assigns to @peer_advisor a PeerAdvisor with the same LDAP UID as the logged in user' do
        post :create
        assigns[:peer_advisor].ldap_id.should == '12345'
      end

      it 'saves the PeerAdvisor' do
        PeerAdvisor.stub(:new).and_return(@peer_advisor)
        @peer_advisor.should_receive(:save)
        post :create
      end

      it 'redirects to the Peer Advisor Dashboard on success' do
        PeerAdvisor.stub(:new).and_return(@peer_advisor)
        @peer_advisor.stub(:new_record?).and_return(true)
        @peer_advisor.stub(:save).and_return(true)
        post :create
        response.should redirect_to(:controller => 'root', :action => 'peer_advisor_dashboard')
      end
    end

    context 'when signed in as a registered Faculty'

    context 'when signed in as an unregistered Faculty' do
      before(:each) do
        CASClient::Frameworks::Rails::Filter.fake('12345')
        LDAP.stub(:find_person).and_return(:role => :faculty)
      end

      it 'redirects to the New Faculty page' do
        post :create
        response.should redirect_to(:controller => 'faculty', :action => 'new')
      end
    end
  end

  describe 'POST import' do
    context 'when not signed in' do
      it 'redirects to the CalNet sign in page' do
        post :import
        response.should redirect_to("#{CASClient::Frameworks::Rails::Filter.config[:login_url]}?service=#{CGI.escape(import_peer_advisors_url)}")
      end
    end

    context 'when signed in as a Staff' do
      before(:each) do
        @csv_text = 'text'
        @peer_advisors = [PeerAdvisor.new, PeerAdvisor.new, PeerAdvisor.new]
        PeerAdvisor.stub(:new_from_csv).and_return(@peer_advisors)
        CASClient::Frameworks::Rails::Filter.fake(@staff.ldap_id)
      end

      it 'assigns to @peer_advisors a collection of PeerAdvisors built from the attributes in each row' do
        PeerAdvisor.should_receive(:new_from_csv).with(@csv_text).and_return(@peer_advisors)
        post :import, :csv_file => @csv_text
        assigns[:peer_advisors].should equal(@peer_advisors)
      end

      context 'when the PeerAdvisor are all valid' do
        before(:each) do
          @peer_advisors.each {|s| s.stub(:valid?).and_return(true)}
        end

        it 'sets a flash[:notice] message' do
          post :import, :csv_file => @csv_text
          flash[:notice].should == I18n.t('people.peer_advisors.import.success')
        end

        it 'redirects to the View Peer Advisors page' do
          post :import, :csv_file => @csv_text
          response.should redirect_to(:controller => 'peer_advisors', :action => 'index')
        end
      end

      context 'when not all of the PeerAdvisors are valid' do
        before(:each) do
          @peer_advisors.first.stub(:valid?).and_return(false)
        end

        it 'renders the upload template' do
          post :import, :csv_file => @csv_text
          response.should render_template('upload')
        end
      end
    end

    context 'when signed in as a registered Peer Advisor'

    context 'when signed in as an unregistered Peer Advisor' do
      before(:each) do
        CASClient::Frameworks::Rails::Filter.fake('12345')
        LDAP.stub(:find_person).and_return(:role => :grad)
      end

      it 'redirects to the New Peer Advisor page' do
        post :import
        response.should redirect_to(:controller => 'peer_advisors', :action => 'new')
      end
    end

    context 'when signed in as a registered Faculty'

    context 'when signed in as an unregistered Faculty' do
      before(:each) do
        CASClient::Frameworks::Rails::Filter.fake('12345')
        LDAP.stub(:find_person).and_return(:role => :faculty)
      end

      it 'redirects to the New Faculty page' do
        post :import
        response.should redirect_to(:controller => 'faculty', :action => 'new')
      end
    end
  end

  describe 'PUT update' do
    context 'when not signed in' do
      it 'redirects to the CalNet sign in page' do
        put :update, :id => @peer_advisor.id
        response.should redirect_to("#{CASClient::Frameworks::Rails::Filter.config[:login_url]}?service=#{CGI.escape(peer_advisor_url(@peer_advisor.id))}")
      end
    end

    context 'when signed in as a Staff' do
      before(:each) do
        PeerAdvisor.stub(:find).and_return(@peer_advisor)
        CASClient::Frameworks::Rails::Filter.fake(@staff.ldap_id)
      end

      it 'assigns to @peer_advisor the given Peer Advisor' do
        PeerAdvisor.should_receive(:find).with(@peer_advisor.id.to_s).and_return(@peer_advisor)
        put :update, :id => @peer_advisor.id
        assigns[:peer_advisor].should equal(@peer_advisor)
      end

      it 'updates the Peer Advisor' do
        @peer_advisor.should_receive(:update_attributes).with('foo' => 'bar')
        put :update, :id => @peer_advisor.id, :peer_advisor => {'foo' => 'bar'}
      end

      context 'when the Peer Advisor is successfully updated' do
        before(:each) do
          @peer_advisor.stub(:update_attributes).and_return(true)
        end
  
        it 'sets a flash[:notice] message' do
          put :update, :id => @peer_advisor.id
          flash[:notice].should == I18n.t('people.peer_advisors.update.success')
        end

        it 'redirects to the given success redirect action' do
          put :update, :id => @peer_advisor.id, :redirect_action => 'index'
          response.should redirect_to(:controller => 'peer_advisors', :action => 'index')
        end
      end

      context 'when the Peer Advisor fails to be saved' do
        before(:each) do
          @peer_advisor.stub(:update_attributes).and_return(false)
        end

        it 'sets the error redirect to the given error action' do
          put :update, :id => @peer_advisor.id, :origin_action => 'edit'
          assigns[:origin_action].should == 'edit'
        end

        it 'sets the success redirect to the index action' do
          put :update, :id => @peer_advisor.id, :redirect_action => 'index'
          assigns[:redirect_action].should == 'index'
        end

        it 'renders the template for the given error action' do
          put :update, :id => @peer_advisor.id, :origin_action => 'edit'
          response.should render_template('edit')
        end
      end
    end

    context 'when signed in as the given Peer Advisor' do
      before(:each) do
        CASClient::Frameworks::Rails::Filter.fake(@peer_advisor.ldap_id)
        Person.stub(:find).and_return(@peer_advisor)
      end

      it 'prevents changes to the LDAP ID' do
        put :update, :id => @peer_advisor.id, :peer_advisor => {:ldap_id => 'foobar'}
        assigns[:peer_advisor].ldap_id.should == @peer_advisor.ldap_id
      end
    end

    context 'when signed in as some other registered Peer Advisor'

    context 'when signed in as an unregistered Peer Advisor' do
      before(:each) do
        CASClient::Frameworks::Rails::Filter.fake('12345')
        LDAP.stub(:find_person).and_return(:role => :grad)
      end

      it 'redirects to the New Peer Advisor page' do
        put :update, :id => @peer_advisor.id
        response.should redirect_to(:controller => 'peer_advisors', :action => 'new')
      end
    end

    context 'when signed in as a registered Faculty'

    context 'when signed in as an unregistered Faculty' do
      before(:each) do
        CASClient::Frameworks::Rails::Filter.fake('12345')
        LDAP.stub(:find_person).and_return(:role => :faculty)
      end

      it 'redirects to the New Faculty page' do
        put :update, :id => @peer_advisor.id
        response.should redirect_to(:controller => 'faculty', :action => 'new')
      end
    end
  end

  describe 'DELETE destroy' do
    context 'when not signed in' do
      it 'redirects to the CalNet sign in page' do
        delete :destroy, :id => @peer_advisor.id
        response.should redirect_to("#{CASClient::Frameworks::Rails::Filter.config[:login_url]}?service=#{CGI.escape(peer_advisor_url(@peer_advisor.id))}")
      end
    end

    context 'when signed in as a Staff' do
      before(:each) do
        PeerAdvisor.stub(:find).and_return(@peer_advisor)
        CASClient::Frameworks::Rails::Filter.fake(@staff.ldap_id)
      end

      it 'assigns to @peer_advisor the given Peer Advisor' do
        PeerAdvisor.should_receive(:find).with(@peer_advisor.id.to_s).and_return(@peer_advisor)
        delete :destroy, :id => @peer_advisor.id
        assigns[:peer_advisor].should equal(@peer_advisor)
      end

      it 'destroys the Peer Advisor' do
        @peer_advisor.should_receive(:destroy)
        delete :destroy, :id => @peer_advisor.id
      end

      it 'sets a flash[:notice] message' do
        delete :destroy, :id => @peer_advisor.id
        flash[:notice].should == I18n.t('people.peer_advisors.destroy.success')
      end

      it 'redirects to the View Peer Advisors page' do
        delete :destroy, :id => @peer_advisor.id
        response.should redirect_to(:controller => 'peer_advisors', :action => 'index')
      end
    end

    context 'when signed in as a registered Peer Advisor'

    context 'when signed in as an unregistered Peer Advisor' do
      before(:each) do
        CASClient::Frameworks::Rails::Filter.fake('12345')
        LDAP.stub(:find_person).and_return(:role => :grad)
      end

      it 'redirects to the New Peer Advisor page' do
        delete :destroy, :id => @peer_advisor.id
        response.should redirect_to(:controller => 'peer_advisors', :action => 'new')
      end
    end

    context 'when signed in as a registered Faculty'

    context 'when signed in as an unregistered Faculty' do
      before(:each) do
        CASClient::Frameworks::Rails::Filter.fake('12345')
        LDAP.stub(:find_person).and_return(:role => :faculty)
      end

      it 'redirects to the New Faculty page' do
        delete :destroy, :id => @peer_advisor.id
        response.should redirect_to(:controller => 'faculty', :action => 'new')
      end
    end
  end

  describe 'DELETE destroy_all' do
    context 'when not signed in' do
      it 'redirects to the CalNet sign in page' do
        delete :destroy_all
        response.should redirect_to("#{CASClient::Frameworks::Rails::Filter.config[:login_url]}?service=#{CGI.escape(destroy_all_peer_advisors_url)}")
      end
    end

    context 'when signed in as a Staff' do
      before(:each) do
        CASClient::Frameworks::Rails::Filter.fake(@staff.ldap_id)
      end

      it 'destroys all peer advisor records' do
        peer_advisors = Array.new(3) {PeerAdvisor.new}
        peer_advisors.each {|p| p.should_receive(:destroy)}
        PeerAdvisor.stub(:find).and_return(peer_advisors)
        delete :destroy_all
      end

      it 'sets a flash[:notice] message' do
        delete :destroy_all
        flash[:notice].should == 'Peer Advisors were all successfully removed.'
      end

      it 'redirects to the View Peer Advisors page' do
        delete :destroy_all
        response.should redirect_to(:controller => 'peer_advisors', :action => 'index')
      end
    end

    context 'when signed in as a registered Peer Advisor'

    context 'when signed in as an unregistered Peer Advisor' do
      before(:each) do
        CASClient::Frameworks::Rails::Filter.fake('12345')
        LDAP.stub(:find_person).and_return(:role => :grad)
      end

      it 'redirects to the New Peer Advisor page' do
        delete :destroy_all
        response.should redirect_to(:controller => 'peer_advisors', :action => 'new')
      end
    end

    context 'when signed in as a registered Faculty'

    context 'when signed in as an unregistered Faculty' do
      before(:each) do
        CASClient::Frameworks::Rails::Filter.fake('12345')
        LDAP.stub(:find_person).and_return(:role => :faculty)
      end

      it 'redirects to the New Faculty page' do
        delete :destroy_all
        response.should redirect_to(:controller => 'faculty', :action => 'new')
      end
    end
  end
end
