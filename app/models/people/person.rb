class Person < ActiveRecord::Base
  include Importable

  ATTRIBUTES = {
    'LDAP ID' => :ldap_id,
    'First Name' => :first_name,
    'Last Name' => :last_name,
    'Email' => :email
  }
  ATTRIBUTE_TYPES = {
    :ldap_id => :string,
    :first_name => :string,
    :last_name => :string,
    :email => :string
  }

  validates_presence_of :ldap_id, :unless => Proc.new {|person| person.class == Admit || person.class == Faculty}
  validates_presence_of :first_name
  validates_presence_of :last_name

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  # Placeholder for future attribute change
  def name
    full_name
  end

  def areas
    [self.area1, self.area2, self.area3]
  end

  named_scope :by_name, :order => 'last_name, first_name'
end
