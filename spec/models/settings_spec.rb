require 'spec_helper'

describe Settings do
  before(:each) do
    @settings = Settings.instance
    @settings.save
  end

  describe 'Attributes' do
    it 'has Meeting Times' do
      @settings.should respond_to(:meeting_times)
      @settings.should respond_to(:meeting_times=)
    end

    it 'has an Unsatisfied Admit Threshold' do
      @settings.should respond_to(:unsatisfied_admit_threshold)
      @settings.should respond_to(:unsatisfied_admit_threshold=)
    end

    it 'has an attribute name to accessor map' do
      Settings::ATTRIBUTES['Meeting Times'].should == :meeting_times
      Settings::ATTRIBUTES['Unsatisfied Admit Threshold'].should == :unsatisfied_admit_threshold
    end

    it 'has an accessor to type map' do
      Settings::ATTRIBUTE_TYPES[:meeting_times].should == :hash
      Settings::ATTRIBUTE_TYPES[:unsatisfied_admit_threshold].should == :integer
    end
  end

  describe 'Static Attributes' do
    it 'has a Meeting Length (meeting_length)' do
      @settings.meeting_length.should == STATIC_SETTINGS['meeting_length']
    end

    it 'has a Meeting Gap (meeting_gap)' do
      @settings.meeting_gap.should == STATIC_SETTINGS['meeting_gap']
    end
  end

  describe 'Associations' do
    it 'has many Divisions' do
      @settings.should have_many(:divisions)
    end
  end

  describe 'Singleton Model' do
    context 'getting an instance' do
      it 'builds an instance if one does not already exist' do
        Settings.destroy_all
        Settings.count.should == 0
        Settings.instance
        Settings.count.should == 1
      end
 
      it 'returns the existent instance if one exists' do
        Settings.instance.should_not be_a_new_record
      end
    end

    it 'does not otherwise allow a new instance to be created' do
      Settings.should_not respond_to(:new)
    end
  end

  context 'when building' do
    it 'by default has a list of empty Meeting Times per Division' do
      STATIC_SETTINGS['divisions'].each do |division_name|
        @settings.meeting_times(division_name).should be_empty
      end
    end

    it 'by default has an Unsatisfied Admit Threshold of 0' do
      @settings.unsatisfied_admit_threshold.should == 0
    end
  end

  context 'when validating' do
    it 'is valid with valid attributes' do
      @settings.should be_valid
    end

    it 'is not valid with invalid Meeting Times'

    it 'is not valid with an invalid Unsatisfied Admit Threshold' do
      ['', -1, 'foobar'].each do |invalid_threshold|
        @settings.unsatisfied_admit_threshold = invalid_threshold
        @settings.should_not be_valid
      end
    end
  end

  context 'when destroying' do
    it 'destroys its Divisions' do
      divisions = Array.new(3) do |i|
        division = Division.new(:name => "Division #{i}")
        division.should_receive(:destroy)
        division
      end
      @settings.stub(:divisions).and_return(divisions)
      @settings.destroy
    end
  end
end
