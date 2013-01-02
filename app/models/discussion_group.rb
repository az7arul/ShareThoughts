class DiscussionGroup
  include Mongoid::Document

  attr_accessible :name

  field :name, :type => String
  field :default, :type => Boolean, :default => false


  has_and_belongs_to_many :users
  has_many :messages


  class << self
    def default
      where(default: true).first ||
          create!(name: "Default Group", default: true)
    end
  end
end
