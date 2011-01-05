require 'spec_helper'

describe Person do
  describe 'Attributes' do
    before(:each) do
      @person = Person.new
    end
    
    it 'has a CalNet ID (calnet_id)' do
      @person.should respond_to(:calnet_id)
      @person.should respond_to(:calnet_id=)
    end

    it 'has a First Name (first_name)' do
      @person.should respond_to(:first_name)
      @person.should respond_to(:first_name=)
    end

    it 'has a Last Name (last_name)' do
      @person.should respond_to(:last_name)
      @person.should respond_to(:last_name=)
    end

    it 'has an Email (email)' do
      @person.should respond_to(:email)
      @person.should respond_to(:email=)
    end
  end

  it 'has an attribute name to accessor map' do
    Person::ATTRIBUTES['CalNet ID'].should == :calnet_id
    Person::ATTRIBUTES['First Name'].should == :first_name
    Person::ATTRIBUTES['Last Name'].should == :last_name
    Person::ATTRIBUTES['Email'].should == :email
  end
end
