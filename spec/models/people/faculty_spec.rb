require 'spec_helper'

describe Faculty do
  before(:each) do
    @faculty = Factory.create(:faculty)
  end

  describe 'Attributes' do
    it 'has an LDAP ID (ldap_id)' do
      @faculty.should respond_to(:ldap_id)
      @faculty.should respond_to(:ldap_id=)
    end

    it 'has a First Name (first_name)' do
      @faculty.should respond_to(:first_name)
      @faculty.should respond_to(:first_name=)
    end

    it 'has a Last Name (last_name)' do
      @faculty.should respond_to(:last_name)
      @faculty.should respond_to(:last_name=)
    end

    it 'has an Email (email)' do
      @faculty.should respond_to(:email)
      @faculty.should respond_to(:email=)
    end

    it 'has an Area (area)' do
      @faculty.should respond_to(:area)
      @faculty.should respond_to(:area=)
    end

    it 'has a Division (division)' do
      @faculty.should respond_to(:division)
      @faculty.should respond_to(:division=)
    end

    it 'has a Default Room (default_room)' do
      @faculty.should respond_to(:default_room)
      @faculty.should respond_to(:default_room=)
    end

    it 'has a Max Admits Per Meeting preference (max_admits_per_meeting)' do
      @faculty.should respond_to(:max_admits_per_meeting)
      @faculty.should respond_to(:max_admits_per_meeting=)
    end

    it 'has a Max Additional Admits to meet with preference (max_additional_admits)' do
      @faculty.should respond_to(:max_additional_admits)
      @faculty.should respond_to(:max_additional_admits=)
    end

    it 'has an attribute name to accessor map' do
      Faculty::ATTRIBUTES['LDAP ID'].should == :ldap_id
      Faculty::ATTRIBUTES['First Name'].should == :first_name
      Faculty::ATTRIBUTES['Last Name'].should == :last_name
      Faculty::ATTRIBUTES['Email'].should == :email
      Faculty::ATTRIBUTES['Area'].should == :area
      Faculty::ATTRIBUTES['Division'].should == :division
      Faculty::ATTRIBUTES['Default Room'].should == :default_room
      Faculty::ATTRIBUTES['Max Admits Per Meeting'].should == :max_admits_per_meeting
      Faculty::ATTRIBUTES['Max Additional Admits'].should == :max_additional_admits
    end

    it 'has an accessor to type map' do
      Faculty::ATTRIBUTE_TYPES[:ldap_id].should == :string
      Faculty::ATTRIBUTE_TYPES[:first_name].should == :string
      Faculty::ATTRIBUTE_TYPES[:last_name].should == :string
      Faculty::ATTRIBUTE_TYPES[:email].should == :string
      Faculty::ATTRIBUTE_TYPES[:area].should == :string
      Faculty::ATTRIBUTE_TYPES[:division].should == :string
      Faculty::ATTRIBUTE_TYPES[:default_room].should == :string
      Faculty::ATTRIBUTE_TYPES[:max_admits_per_meeting].should == :integer
      Faculty::ATTRIBUTE_TYPES[:max_additional_admits].should == :integer
    end
  end

  describe 'Virtual Attributes' do
    it 'has a Full Name (full_name)' do
      @faculty.full_name.should == "#{@faculty.first_name} #{@faculty.last_name}"
    end
  end

  describe 'Named Scopes' do
    it 'has a list of Faculty sorted by last and first name (by_name)' do
      @faculty.update_attributes(:first_name => 'Foo', :last_name => 'Bar')
      Factory.create(:faculty, :first_name => 'Ccc', :last_name => 'Ccc')
      Factory.create(:faculty, :first_name => 'Jack', :last_name => 'Bbb')
      Factory.create(:faculty, :first_name => 'Jill', :last_name => 'Bbb')
      Faculty.by_name.map {|a| "#{a.first_name} #{a.last_name}"}.should == ['Foo Bar', 'Jack Bbb', 'Jill Bbb', 'Ccc Ccc']
    end
  end

  describe 'Associations' do
    describe 'Available Times' do
      it 'has many Available Times (available_times)' do
        @faculty.should have_many(:available_times)
      end

      it 'has many Available Times sorted by Start Time' do
        @faculty.available_times.create(:begin => Time.zone.parse('1/4/2011'), :end => Time.zone.parse('1/5/2011'))
        @faculty.available_times.create(:begin => Time.zone.parse('1/3/2011'), :end => Time.zone.parse('1/4/2011'))
        @faculty.available_times.create(:begin => Time.zone.parse('1/6/2011'), :end => Time.zone.parse('1/7/2011'))
        @faculty.available_times.reload.map {|t| t.attributes['begin']}.should == [
          Time.zone.parse('1/3/2011'),
          Time.zone.parse('1/4/2011'),
          Time.zone.parse('1/6/2011'),
        ]
      end
    end

    describe 'Admit Rankings' do
      it 'has many Admit Rankings (admit_rankings)' do
        @faculty.should have_many(:admit_rankings)
      end

      it 'has many Faculty Rankings sorted by rank' do
        @faculty.admit_rankings.create(:rank => 2, :admit => Factory.create(:admit))
        @faculty.admit_rankings.create(:rank => 1, :admit => Factory.create(:admit))
        @faculty.admit_rankings.create(:rank => 3, :admit => Factory.create(:admit))
        @faculty.admit_rankings.reload.map {|r| r.attributes['rank']}.should == [1, 2, 3]
      end
    end

    it 'has many Meetings (meetings)' do
      @faculty.should have_many(:meetings)
    end
  end

  describe 'Nested Attributes' do
    describe 'Available Times (available_times)' do
      it 'allows nested attributes for Available Times (available_times)' do
        attributes = {:available_times_attributes => [
          {:begin => Time.zone.parse('1/1/2011'), :end => Time.zone.parse('1/2/2011')},
          {:begin => Time.zone.parse('1/3/2011'), :end => Time.zone.parse('1/4/2011')}
        ]}
        @faculty.attributes = attributes
        @faculty.available_times.each_with_index do |time, i|
          time.begin.should == attributes[:available_times_attributes][i][:begin]
          time.end.should == attributes[:available_times_attributes][i][:end]
        end
      end

      it 'ignores completely blank entries' do
        attributes = {:available_times_attributes => [
          {:begin => Time.zone.parse('1/1/2011'), :end => Time.zone.parse('1/2/2011')},
          {:begin => '', :end => ''}
        ]}
        @faculty.attributes = attributes
        @faculty.available_times.length.should == 1
      end
    end

    describe 'Admit Rankings (admit_rankings)' do
      before(:each) do
        @admit1 = Factory.create(:admit)
        @admit2 = Factory.create(:admit)
      end

      it 'allows nested attributes for Admit Rankings (admit_rankings)' do
        attributes = {:admit_rankings_attributes => [
          {:rank => 1, :admit => @admit1},
          {:rank => 2, :admit => @admit2}
        ]}
        @faculty.attributes = attributes
        @faculty.admit_rankings.map {|r| r.admit.id}.should == [@admit1.id, @admit2.id]
      end

      it 'ignores entries with blank ranks' do
        attributes = {:admit_rankings_attributes => [
          {:rank => 1, :admit => @admit1},
          {:rank => '', :admit => @admit2}
        ]}
        @faculty.attributes = attributes
        @faculty.admit_rankings.length.should == 1
      end

      it 'allows deletion' do
        attributes = {:admit_rankings_attributes => [
          {:rank => 1, :admit => @admit1},
          {:rank => 2, :admit => @admit2}
        ]}
        @faculty.attributes = attributes
        @faculty.save

        delete_id = @faculty.admit_rankings.first.id
        new_attributes = {:admit_rankings_attributes => [
          {:id => delete_id, :_destroy => true}
        ]}
        @faculty.attributes = new_attributes
        @faculty.admit_rankings.detect {|r| r.id == delete_id}.should be_marked_for_destruction
      end
    end
  end

  context 'when building' do
    before(:each) do
      @faculty = Faculty.new
    end

    it 'has no default room (None)' do
      @faculty.default_room.should == 'None'
    end

    it 'has a default Max Admits Per Meeting preference of 1' do
      @faculty.max_admits_per_meeting.should == 1
    end

    it 'has a Max Additional Admits to meet with preference of 100' do
      @faculty.max_additional_admits.should == 100 
    end
  end

  context 'when validating' do
    it 'is valid with valid attributes' do
      @faculty.should be_valid
    end

    it 'is not valid without an LDAP ID' do
      @faculty.ldap_id = ''
      @faculty.should_not be_valid
    end

    it 'is not valid without a First Name' do
      @faculty.first_name = ''
      @faculty.should_not be_valid
    end

    it 'is not valid without a Last Name' do
      @faculty.last_name = ''
      @faculty.should_not be_valid
    end

    it 'is not valid without an Email' do
      @faculty.email = ''
      @faculty.should_not be_valid
    end

    it 'is not valid with an invalid Email' do
      ['foobar', 'foo@bar', 'foo.com'].each do |invalid_email|
        @faculty.email = invalid_email
        @faculty.should_not be_valid
      end
    end

    it 'is not valid with an invalid Division' do
      stub_divisions('D1' => 'Division 1', 'D2' => 'Division 2')
      ['', 'Division 3', 123].each do |invalid_division|
        @faculty.division = invalid_division
        @faculty.should_not be_valid
      end
    end

    it 'is not valid with an invalid Area' do
      stub_areas('A1' => 'Area 1', 'A2' => 'Area 2')
      ['', 'Area 3', 123].each do |invalid_area|
        @faculty.area = invalid_area
        @faculty.should_not be_valid
      end
    end

    it 'is valid with a valid division' do
      Settings.instance.divisions.map(&:name).each do |division|
        @faculty.division = division
        @faculty.should be_valid
      end
    end

    it 'is not valid with an invalid division' do
      ['', 1, 'invalid_division'].each do |invalid_division|
        @faculty.division = invalid_division
        @faculty.should_not be_valid
      end
    end

    it 'is not valid without a Division' do
      @faculty.division = ''
      @faculty.should_not be_valid
    end

    it 'is not valid with invalid Available Times' do
      @faculty.available_times.build
      @faculty.should_not be_valid
    end

    it 'is not valid with overlapping Available Times' do
      [
        [
          AvailableTime.new(:begin => Time.zone.parse('1/5/2011'), :end => Time.zone.parse('1/8/2011')),
          AvailableTime.new(:begin => Time.zone.parse('1/6/2011'), :end => Time.zone.parse('1/8/2011'))
        ],
        [
          AvailableTime.new(:begin => Time.zone.parse('1/5/2011'), :end => Time.zone.parse('1/8/2011')),
          AvailableTime.new(:begin => Time.zone.parse('1/6/2011'), :end => Time.zone.parse('1/9/2011'))
        ],
        [
          AvailableTime.new(:begin => Time.zone.parse('1/5/2011'), :end => Time.zone.parse('1/8/2011')),
          AvailableTime.new(:begin => Time.zone.parse('1/6/2011'), :end => Time.zone.parse('1/7/2011'))
        ]
      ].each do |times|
        @faculty.available_times = times
        @faculty.should_not be_valid
      end
    end

    it 'is valid with overlapping Available Times that are marked for destruction' do
      time1 = AvailableTime.new(:begin => Time.zone.parse('1/5/2011'), :end => Time.zone.parse('1/8/2011'))
      time2 = AvailableTime.new(:begin => Time.zone.parse('1/6/2011'), :end => Time.zone.parse('1/8/2011'))
      time3 = AvailableTime.new(:begin => Time.zone.parse('1/7/2011'), :end => Time.zone.parse('1/9/2011'))
      @faculty.available_times = [time1, time2, time3]
      time1.mark_for_destruction
      time2.mark_for_destruction
      @faculty.should be_valid
    end

    it 'is not valid without a Default Doom' do
      @faculty.default_room = ''
      @faculty.should_not be_valid
    end

    it 'is not valid with an invalid Max Admits Per Meeting preference' do
      ['', 0, -1, 5.5, 'foobar'].each do |invalid_preference|
        @faculty.max_admits_per_meeting = invalid_preference
        @faculty.should_not be_valid
      end
    end

    it 'is not valid with an invalid Max Additional Admits to meet with preference' do
      ['', -1, 5.5, 'foobar'].each do |invalid_preference|
        @faculty.max_additional_admits = invalid_preference
        @faculty.should_not be_valid
      end
    end

    it 'is not valid with non-unique Admit Ranking ranks' do
      admit_rankings = [
        AdmitRanking.new(:rank => 1, :admit => Factory.create(:admit)),
        AdmitRanking.new(:rank => 1, :admit => Factory.create(:admit))
      ]
      @faculty.admit_rankings = admit_rankings
      @faculty.should_not be_valid
    end

    it 'is valid with non-unique Admit Rankings that are marked for destruction' do
      admit_rankings = [
        AdmitRanking.new(:rank => 1, :admit => Factory.create(:admit)),
        AdmitRanking.new(:rank => 1, :admit => Factory.create(:admit)),
        AdmitRanking.new(:rank => 1, :admit => Factory.create(:admit))
      ]
      admit_rankings[0].mark_for_destruction
      admit_rankings[1].mark_for_destruction
      @faculty.admit_rankings = admit_rankings
      @faculty.should be_valid
    end
  end

  context 'after validating' do
    it 'maps Area to its canonical form' do
      stub_areas('A1' => 'Area 1', 'A2' => 'Area 2')
      ['A1', 'Area 1'].each do |area|
        @faculty.area = area
        @faculty.valid?
        @faculty.area.should == 'A1'
      end

      @faculty.area = nil
      @faculty.valid?
      @faculty.area.should == nil
    end

    it 'maps Division to its canonical form' do
      stub_divisions('D1' => 'Division 1', 'D2' => 'Division 2')
      ['D1', 'Division 1'].each do |division|
        @faculty.division = division
        @faculty.valid?
        @faculty.division.should == 'D1'
      end

      @faculty.division = nil
      @faculty.valid?
      @faculty.division.should == nil
    end
  end

  context 'when destroying' do
    it 'destroys its Available Times' do
      available_times = Array.new(3) do |i|
        available_time = AvailableTime.create(
          :begin => Time.zone.parse("1:00PM 1/#{i + 1}/2011"),
          :end => Time.zone.parse("5:00PM 1/#{i + 1}/2011")
        )
        available_time.should_receive(:destroy)
        available_time
      end
      @faculty.stub(:available_times).and_return(available_times)
      @faculty.destroy
    end

    it 'destroys its Admit Rankings' do
      admit_rankings = Array.new(3) do
        admit_ranking = Factory.create(:admit_ranking, :faculty => @faculty)
        admit_ranking.should_receive(:destroy)
        admit_ranking
      end
      @faculty.stub(:admit_rankings).and_return(admit_rankings)
      @faculty.destroy
    end

    it 'destroys the Faculty Rankings to which it belongs' do
      faculty_rankings = Array.new(3) do
        faculty_ranking = Factory.create(:faculty_ranking, :faculty => @faculty)
        faculty_ranking.should_receive(:destroy)
        faculty_ranking
      end
      @faculty.stub(:faculty_rankings).and_return(faculty_rankings)
      @faculty.destroy
    end

    it 'destroys its Meetings' do
      meetings = Array.new(3) do
        meeting = Factory.create(:meeting, :faculty => @faculty)
        meeting.should_receive(:destroy)
        meeting
      end
      @faculty.stub(:meetings).and_return(meetings)
      @faculty.destroy
    end
  end

  context 'when importing a CSV' do
    before(:each) do
      @faculties = Array.new(3) {Faculty.new}
      new_faculties = @faculties.dup
      Faculty.stub(:new) do |*args|
        faculty = new_faculties.shift
        faculty.attributes = args[0]
        faculty
      end
    end

    it 'builds a collection of Faculty with the attributes in each row' do
      csv_text = <<-EOF.gsub(/^ {8}/, '')
        First Name,Last Name,Email,Division,Area,Default Room,Max Admits Per Meeting,Max Additional Admits
        First0,Last0,email0@email.com,Division0,Area0,Room0,1,0
        First1,Last1,email1@email.com,Division1,Area1,Room1,2,1
        First2,Last2,email2@email.com,Division2,Area2,Room2,3,2
      EOF
      Faculty.new_from_csv(csv_text).should == @faculties
      @faculties.each_with_index do |faculty, i|
        faculty.first_name.should == "First#{i}"
        faculty.last_name.should == "Last#{i}"
        faculty.email.should == "email#{i}@email.com"
        faculty.division.should == "Division#{i}"
        faculty.area.should == "Area#{i}"
        faculty.default_room.should == "Room#{i}"
        faculty.max_admits_per_meeting.should == i + 1
        faculty.max_additional_admits.should == i
      end
    end

    it 'ignores extraneous attributes' do
      csv_text = <<-EOF.gsub(/^ {8}/, '')
        Baz,First Name,Last Name,Email,Division,Area,Default Room,Max Admits Per Meeting,Max Additional Admits,Foo,Bar
        Baz0,First0,Last0,email0@email.com,Division0,Area0,Room0,1,0,Foo0,Bar0
        Baz1,First1,Last1,email1@email.com,Division1,Area1,Room1,2,1,Foo1,Bar1
        Baz2,First2,Last2,email2@email.com,Division2,Area2,Room2,3,2,Foo2,Bar2
      EOF
      Faculty.new_from_csv(csv_text).should == @faculties
      @faculties.each_with_index do |faculty, i|
        faculty.first_name.should == "First#{i}"
        faculty.last_name.should == "Last#{i}"
        faculty.email.should == "email#{i}@email.com"
        faculty.division.should == "Division#{i}"
        faculty.area.should == "Area#{i}"
        faculty.default_room.should == "Room#{i}"
        faculty.max_admits_per_meeting.should == i + 1
        faculty.max_additional_admits.should == i
      end
    end
  end

  context 'when building a list of time slots' do
    before(:each) do
      @meeting_times = [
        AvailableTime.new(:begin => Time.zone.parse('1/1/2011 8AM'), :end => Time.zone.parse('1/1/2011 9AM')),
        AvailableTime.new(:begin => Time.zone.parse('1/1/2011 10AM'), :end => Time.zone.parse('1/1/2011 10:15AM')),
        AvailableTime.new(:begin => Time.zone.parse('1/1/2011 10:30AM'), :end => Time.zone.parse('1/1/2011 11AM'))
      ]
      @meeting_length = 15 * 60
      @meeting_gap = 5 * 60
    end

    context 'when no available meeting slots have been specified' do
      it 'partitions the given times and produces an AvailableTime for each resulting slot' do
        @faculty.build_available_times(@meeting_times, @meeting_length, @meeting_gap)
        @faculty.available_times.map {|t| {:begin => t.begin, :end => t.end}}.should == [
          {:begin => Time.zone.parse('1/1/2011 8AM'), :end => Time.zone.parse('1/1/2011 8:15AM')},
          {:begin => Time.zone.parse('1/1/2011 8:20AM'), :end => Time.zone.parse('1/1/2011 8:35AM')},
          {:begin => Time.zone.parse('1/1/2011 8:40AM'), :end => Time.zone.parse('1/1/2011 8:55AM')},
          {:begin => Time.zone.parse('1/1/2011 10AM'), :end => Time.zone.parse('1/1/2011 10:15AM')},
          {:begin => Time.zone.parse('1/1/2011 10:30AM'), :end => Time.zone.parse('1/1/2011 10:45AM')}
        ]
      end
    end

    context 'when some available meeting times have been specified' do
      it 'partitions the given times - already specified times and produces an AvailableTime for each resulting slot' do
        specified_times = [
          AvailableTime.new(:begin => Time.zone.parse('1/1/2011 8AM'), :end => Time.zone.parse('1/1/2011 8:15AM')),
          AvailableTime.new(:begin => Time.zone.parse('1/1/2011 10AM'), :end => Time.zone.parse('1/1/2011 10:15AM'))
        ]
        @faculty.available_times += specified_times
        @faculty.save
        @faculty.build_available_times(@meeting_times, @meeting_length, @meeting_gap)
        @faculty.available_times.map {|t| {:begin => t.begin, :end => t.end}}.should == [
          {:begin => Time.zone.parse('1/1/2011 8AM'), :end => Time.zone.parse('1/1/2011 8:15AM')},
          {:begin => Time.zone.parse('1/1/2011 8:20AM'), :end => Time.zone.parse('1/1/2011 8:35AM')},
          {:begin => Time.zone.parse('1/1/2011 8:40AM'), :end => Time.zone.parse('1/1/2011 8:55AM')},
          {:begin => Time.zone.parse('1/1/2011 10AM'), :end => Time.zone.parse('1/1/2011 10:15AM')},
          {:begin => Time.zone.parse('1/1/2011 10:30AM'), :end => Time.zone.parse('1/1/2011 10:45AM')}
        ]
        [0, 3].each {|i| @faculty.available_times[i].should_not be_a_new_record}
        [1, 2, 4].each {|i| @faculty.available_times[i].should be_a_new_record}
      end
    end
  end
end
