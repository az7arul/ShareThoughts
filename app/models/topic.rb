class Topic
  include Mongoid::Document
  include Mongoid::Timestamps

  attr_accessible :content

  field :content, type: String

  validates_presence_of :content

  has_many :messages
  belongs_to :discussion_group
end
