class Message
  include Mongoid::Document
  include Mongoid::Timestamps

  attr_accessible :content

  field :content, type: String

  validates_presence_of :content


  belongs_to :user
  belongs_to :discussion_group
  belongs_to :topic

  validates :user_id, :presence => true
  validates :discussion_group_id, :presence => true

end
