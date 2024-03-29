require 'casclient/frameworks/rails/filter'

class ApplicationController < ActionController::Base
  prepend_before_filter CASClient::Frameworks::Rails::Filter
  before_filter :get_current_user
  before_filter :verify_new_user

  self.allow_forgery_protection = false

  private

  def get_current_user
    person = Staff.find_by_ldap_id(session[:cas_user]) ||
             PeerAdvisor.find_by_ldap_id(session[:cas_user]) ||
             Faculty.find_by_ldap_id(session[:cas_user])
    (@current_user = person) && return unless person.nil?

    entry = LDAP.find_person(session[:cas_user])
    unless entry.nil?
      attributes = {
        :ldap_id => entry[:uid],
        :first_name => entry[:first_name],
        :last_name => entry[:last_name],
        :email => entry[:email]
      }
      @current_user = (entry[:role] == :faculty) ? Faculty.new(attributes) :
                      (entry[:role] == :grad) ? PeerAdvisor.new(attributes) :
                      nil
    end
  end

  def verify_new_user
    model_name = @current_user.class.name
    if @current_user.new_record? && !(params[:controller] == model_name.tableize && ['new', 'create'].include?(params[:action]))
      redirect_to(:controller => model_name.tableize, :action => 'new')
    end
  end
end
