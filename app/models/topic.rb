class Topic
  include Mongoid::Document
  include Mongoid::Timestamps

  attr_accessible :content

  field :content, type: String

  has_many :messages
  belongs_to :discussion_group
end
