class Admit < Person
  include Schedulable

  ATTRIBUTES = Person::ATTRIBUTES.merge({
    'Phone' => :phone,
    'Area 1' => :area1,
    'Area 2' => :area2
  })
  ATTRIBUTE_TYPES = Person::ATTRIBUTE_TYPES.merge({
    :phone => :string,
    :area1 => :string,
    :area2 => :string
  })

  after_validation do |record| # Map Areas to their canonical forms
    areas = Settings.instance.areas.invert
    record.area1 = areas[record.area1] unless record.area1.nil? || areas[record.area1].nil?
    record.area2 = areas[record.area2] unless record.area2.nil? || areas[record.area2].nil?
  end

  after_validation do |record| # destroy available_times not flagged as available
    record.available_times.each {|t| t.destroy unless t.available}
  end

  has_many :faculty_rankings, :order => 'rank ASC', :dependent => :destroy
  accepts_nested_attributes_for :faculty_rankings, :reject_if => proc {|attr| attr['rank'].blank?}, :allow_destroy => true
  has_and_belongs_to_many :meetings, :uniq => true

  validates_presence_of :phone
  validates_inclusion_of :area1, :in => Settings.instance.areas.to_a.flatten, :allow_blank => true
  validates_inclusion_of :area2, :in => Settings.instance.areas.to_a.flatten, :allow_blank => true
  validate do |record| # uniqueness of ranks in faculty_rankings
    ranks = record.faculty_rankings.map(&:rank)
    if ranks.count != ranks.uniq.count
      record.errors.add_to_base('Ranks must be unique')
    end
  end
end
