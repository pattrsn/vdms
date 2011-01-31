require 'spec_helper'

describe Admit do
  before(:each) do
    @admit = Factory.create(:admit)
  end

  describe 'Attributes' do
    it 'has a First Name (first_name)' do
      @admit.should respond_to(:first_name)
      @admit.should respond_to(:first_name=)
    end

    it 'has a Last Name (last_name)' do
      @admit.should respond_to(:last_name)
      @admit.should respond_to(:last_name=)
    end

    it 'has an Email (email)' do
      @admit.should respond_to(:email)
      @admit.should respond_to(:email=)
    end

    it 'has a Phone (phone)' do
      @admit.should respond_to(:phone)
      @admit.should respond_to(:phone=)
    end

    it 'has an Area 1 (area1)' do
      @admit.should respond_to(:area1)
      @admit.should respond_to(:area1=)
    end

    it 'has an Area 2 (area2)' do
      @admit.should respond_to(:area2)
      @admit.should respond_to(:area2=)
    end

    it 'has an attribute name to accessor map' do
      Admit::ATTRIBUTES['CalNet ID'].should == :calnet_id
      Admit::ATTRIBUTES['First Name'].should == :first_name
      Admit::ATTRIBUTES['Last Name'].should == :last_name
      Admit::ATTRIBUTES['Email'].should == :email
      Admit::ATTRIBUTES['Phone'].should == :phone
      Admit::ATTRIBUTES['Area 1'].should == :area1
      Admit::ATTRIBUTES['Area 2'].should == :area2
    end

    it 'has an accessor to type map' do
      Admit::ATTRIBUTE_TYPES[:calnet_id].should == :string
      Admit::ATTRIBUTE_TYPES[:first_name].should == :string
      Admit::ATTRIBUTE_TYPES[:last_name].should == :string
      Admit::ATTRIBUTE_TYPES[:email].should == :string
      Admit::ATTRIBUTE_TYPES[:phone].should == :string
      Admit::ATTRIBUTE_TYPES[:area1].should == :string
      Admit::ATTRIBUTE_TYPES[:area2].should == :string
    end
  end

  describe 'Associations' do
    it 'belongs to a Peer Advisor (peer_advisor)' do
      @admit.should belong_to(:peer_advisor)
    end

    it 'has many Available Times (available_times)' do
      @admit.should have_many(:available_times)
    end

    it 'has many Faculty Rankings (faculty_rankings)' do
      @admit.should have_many(:faculty_rankings)
    end

    it 'has and belongs to many Meetings (meetings)' do
      @admit.should have_and_belong_to_many(:meetings)
    end
  end

  describe 'Nested Attributes' do
    describe 'Available Times (available_times)' do
      it 'allows nested attributes for Available Times (available_times)' do
        attributes = {:available_times_attributes => [
          {:begin => Time.zone.parse('1/1/2011'), :end => Time.zone.parse('1/2/2011')},
          {:begin => Time.zone.parse('1/3/2011'), :end => Time.zone.parse('1/4/2011')}
        ]}
        @admit.attributes = attributes
        @admit.available_times.each_with_index do |time, i|
          time.begin.should == attributes[:available_times_attributes][i][:begin]
          time.end.should == attributes[:available_times_attributes][i][:end]
        end
      end
  
      it 'ignores completely blank entries' do
        attributes = {:available_times_attributes => [
          {:begin => Time.zone.parse('1/1/2011'), :end => Time.zone.parse('1/2/2011')},
          {:begin => '', :end => ''}
        ]}
        @admit.attributes = attributes
        @admit.available_times.length.should == 1
      end
    end
  end

  context 'when validating' do
    it 'is valid with valid attributes' do
      @admit.should be_valid
    end

    it 'is not valid without a First Name' do
      @admit.first_name = ''
      @admit.should_not be_valid
    end

    it 'is not valid without a Last Name' do
      @admit.last_name = ''
      @admit.should_not be_valid
    end

    it 'is not valid without an Email' do
      @admit.email = ''
      @admit.should_not be_valid
    end

    it 'is not valid with an invalid Email' do
      ['foobar', 'foo@bar', 'foo.com'].each do |invalid_email|
        @admit.email = invalid_email
        @admit.should_not be_valid
      end
    end

    it 'is valid with a valid Phone' do
      ['1234567890', '(123) 456-7890', '123.456.7890', '123-456-7890'].each do |valid_phone|
        @admit.phone = valid_phone
        @admit.should be_valid
      end
    end

    it 'is not valid without a Phone' do
      @admit.phone = ''
      @admit.should_not  be_valid
    end

    it 'is not valid with an invalid Phone' do
      ['12345678', 'foobarbaz', '12345678900'].each do |invalid_phone|
        @admit.phone = invalid_phone
        @admit.should_not be_valid
      end
    end

    it 'is not valid without an Area 1' do
      @admit.area1 = ''
      @admit.should_not be_valid
    end

    it 'is not valid without an Area 2' do
      @admit.area2 = ''
      @admit.should_not be_valid
    end

    it 'is valid with valid non-overlapping Available Times' do
      [
        [
          AvailableTime.new(:begin => Time.zone.parse('1/5/2011'), :end => Time.zone.parse('1/8/2011')),
          AvailableTime.new(:begin => Time.zone.parse('1/8/2011'), :end => Time.zone.parse('1/9/2011'))
        ],
        [
          AvailableTime.new(:begin => Time.zone.parse('1/5/2011'), :end => Time.zone.parse('1/6/2011')),
          AvailableTime.new(:begin => Time.zone.parse('1/6/2011'), :end => Time.zone.parse('1/7/2011'))
        ]
      ].each do |times|
        @admit.available_times = times
        @admit.should be_valid
      end
    end

    it 'is not valid with invalid Available Times' do
      @admit.available_times.build
      @admit.should_not be_valid
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
        @admit.available_times = times
        @admit.should_not be_valid
      end
    end

    it 'is not valid with an invalid Peer Advisor' do
      @admit.peer_advisor = PeerAdvisor.new
      @admit.should_not be_valid
    end
  end

  context 'after validating' do
    it 'parses and formats Phone' do
      ['1234567890', '123-456-7890', '123.456.7890'].each do |phone|
        @admit.phone = phone
        @admit.valid?
        @admit.phone.should == '(123) 456-7890'
      end
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
      @admit.stub(:available_times).and_return(available_times)
      @admit.destroy
    end

    it 'destroys its Faculty Rankings' do
      faculty_rankings = Array.new(3) do
        faculty_ranking = Factory.create(:faculty_ranking, :admit => @admit)
        faculty_ranking.should_receive(:destroy)
        faculty_ranking
      end
      @admit.stub(:faculty_rankings).and_return(faculty_rankings)
      @admit.destroy
    end
  end

  context 'when importing a CSV' do
    before(:each) do
      @admits = Array.new(3) {Admit.new}
      new_admits = @admits.dup
      Admit.stub(:new) do |*args|
        admit = new_admits.shift
        admit.attributes = args[0]
        admit
      end
    end

    it 'builds a collection of Admits with the attributes in each row' do
      csv_text = <<-EOF.gsub(/^ {8}/, '')
        CalNet ID,First Name,Last Name,Email,Phone,Area 1,Area 2
        ID0,First0,Last0,email0@email.com,1234567890,Area 10,Area 20
        ID1,First1,Last1,email1@email.com,1234567891,Area 11,Area 21
        ID2,First2,Last2,email2@email.com,1234567892,Area 12,Area 22
      EOF
      Admit.new_from_csv(csv_text).should == @admits
      @admits.each_with_index do |admit, i|
        admit.calnet_id.should == "ID#{i}"
        admit.first_name.should == "First#{i}"
        admit.last_name.should == "Last#{i}"
        admit.email.should == "email#{i}@email.com"
        admit.phone.should == "123456789#{i}"
        admit.area1.should == "Area 1#{i}"
        admit.area2.should == "Area 2#{i}"
      end
    end

    it 'ignores extraneous attributes' do
      csv_text = <<-EOF.gsub(/^ {8}/, '')
        CalNet ID,Baz,First Name,Last Name,Email,Phone,Area 1,Area 2,Foo,Bar
        ID0,Baz0,First0,Last0,email0@email.com,1234567890,Area 10,Area 20,Foo0,Bar0
        ID1,Baz1,First1,Last1,email1@email.com,1234567891,Area 11,Area 21,Foo1,Bar1
        ID2,Baz2,First2,Last2,email2@email.com,1234567892,Area 12,Area 22,Foo2,Bar2
      EOF
      Admit.new_from_csv(csv_text).should == @admits
      @admits.each_with_index do |admit, i|
        admit.calnet_id.should == "ID#{i}"
        admit.first_name.should == "First#{i}"
        admit.last_name.should == "Last#{i}"
        admit.email.should == "email#{i}@email.com"
        admit.phone.should == "123456789#{i}"
        admit.area1.should == "Area 1#{i}"
        admit.area2.should == "Area 2#{i}"
      end
    end

  end
end