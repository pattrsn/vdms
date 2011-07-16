class Faculty < Person
  include Schedulable

  ATTRIBUTES = Person::ATTRIBUTES.merge({
    'Area 1' => :area1,
    'Area 2' => :area2,
    'Area 3' => :area3,
    'Division' => :division,
    'Default Room' => :default_room,
    'Max Admits Per Meeting' => :max_admits_per_meeting,
    'Max Additional Admits' => :max_additional_admits
  })
  ATTRIBUTE_TYPES = Person::ATTRIBUTE_TYPES.merge({
    :area1 => :string,
    :area2 => :string,
    :area3 => :string,
    :division => :string,
    :default_room => :string,
    :max_admits_per_meeting => :integer,
    :max_additional_admits => :integer
  })

  def after_initialize
    if self.new_record?
      self.default_room ||= 'None'
      self.max_admits_per_meeting ||= 1
      self.max_additional_admits ||= 100
    end
  end
  after_validation do |record| # Map Area and Division to their canonical forms
    settings = Settings.instance
    areas = settings.areas.invert
    divisions = settings.divisions.invert
    record.area1 = areas[record.area1] unless record.area1.nil? || areas[record.area1].nil?
    record.area2 = areas[record.area2] unless record.area2.nil? || areas[record.area2].nil?
    record.area3 = areas[record.area3] unless record.area3.nil? || areas[record.area3].nil?
    record.division = divisions[record.division] unless record.division.nil? || divisions[record.division].nil?
  end
  after_create do |record|
    Settings.instance.time_slots.each do |time_slot|
      record.availabilities.create(:time_slot => time_slot, :available => false)
    end
  end

  has_many :admit_rankings, :order => 'rank ASC', :dependent => :destroy
  has_many :ranked_admits, :source => :admit, :through => :admit_rankings, :order => 'rank ASC'
  has_many :ranked_one_on_one_admits, :source => :admit, :through => :admit_rankings, :conditions => ['rankings.one_on_one = ?', true]
  has_many :mandatory_admits, :source => :admit, :through => :admit_rankings, :conditions => ['rankings.mandatory = ?', true]
  has_many :faculty_rankings, :dependent => :destroy
  has_many :availabilities, :class_name => 'HostAvailability', :foreign_key => 'host_id', :dependent => :destroy
  has_many :meetings, :through => :availabilities
  accepts_nested_attributes_for :availabilities, :reject_if => :all_blank
  accepts_nested_attributes_for :admit_rankings, :reject_if => proc {|attr| attr['rank'].blank?}, :allow_destroy => true

  validates_presence_of :email
  validates_format_of :email, :with => /^([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})$/i
  validates_inclusion_of :area1, :in => Settings.instance.areas.to_a.flatten, :allow_blank => true
  validates_inclusion_of :area2, :in => Settings.instance.areas.to_a.flatten, :allow_blank => true
  validates_inclusion_of :area3, :in => Settings.instance.areas.to_a.flatten, :allow_blank => true
  validates_inclusion_of :division, :in => Settings.instance.divisions.to_a.flatten
  validates_presence_of :default_room
  validates_presence_of :max_admits_per_meeting
  validates_numericality_of :max_admits_per_meeting, :only_integer => true, :greater_than => 0
  validates_presence_of :max_additional_admits
  validates_numericality_of :max_additional_admits, :only_integer => true, :greater_than_or_equal_to => 0
  validate do |record| # uniqueness of ranks in admit_rankings
    ranks = record.admit_rankings.reject(&:marked_for_destruction?).map(&:rank)
    if ranks.count != ranks.uniq.count
      record.errors.add_to_base('Ranks must be unique')
    end
  end

  def area
    self.area1
  end

  def area=(new_area)
    self.area1 = new_area
  end
  
  def available_at?(time)
    availabilities.any?{ |a| a.time_slot.begin == time and a.available? }
    # incorrect code
    # time_slots.map(&:begin).include?(time)
  end

  def room_for(time)
    availability = availabilities.detect {|a| a.time_slot && a.time_slot.begin == time}
    availability.nil? ?
        default_room :
        availability.room.blank? ?
            default_room :
            availability.room
  end

  def self.attending_faculties
    Faculty.all.select {|faculty| faculty.time_slots.select {|time_slot| time_slot.available?}.count > 0}
  end
end
