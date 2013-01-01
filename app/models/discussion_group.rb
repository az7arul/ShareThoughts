class DiscussionGroup
  include Mongoid::Document

  field :name, :type => String
  field :default_group, :type => Boolean, :default => false


  has_and_belongs_to_many :users


  def self.get_default_group
    if (group = where(default_group: true).first)
      group
    else
      create!(name: "Default Group", default_group: true)
    end
  end
end
