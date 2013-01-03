class TopicsController < ApplicationController

  before_filter :authenticate_user!

  def create
    @topic = DiscussionGroup.new(params[:topic])
    redirect_with_message notice: 'Successfully create new Topic',
                          alert: 'Failed to create new Topic',
                          if: -> { @topic.save }
  end

  def change_topic
    @group = DiscussionGroup.find(params[:group_id])
    topic = Topic.create!(content: params[:topic])
    @group.topic = topic
    @group.save
  end
end