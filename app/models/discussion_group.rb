class DiscussionGroup
  include Mongoid::Document

  before_create :generate_default_topic

  attr_accessible :name

  field :name, :type => String
  field :default, :type => Boolean, :default => false


  has_and_belongs_to_many :users
  has_many :messages
  has_one :topic

  accepts_nested_attributes_for :topic

  validates_presence_of :name
  validates_uniqueness_of :name

  def generate_default_topic
    self.topic = topic || Topic.new(content: "Welcome to #{name}")
  end

  class << self
    def default
      where(default: true).first ||
          create!(name: "Default Group", default: true)
    end
  end
end
