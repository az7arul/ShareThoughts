class Message
  include Mongoid::Document
  include Mongoid::Timestamps

  field :content, type: String


  belongs_to :user
  belongs_to :discussion_group

  validates :user_id, :presence => true
  validates :discussion_group_id, :presence => true

end
