class TopicsController < ApplicationController

  before_filter :authenticate_user!
 # before_filter :ensure_admin!


  def create
    @topic = DiscussionGroup.new(params[:topic])
    redirect_with_message notice: 'Successfully create new Topic',
                          alert: 'Failed to create new Topic',
                          if: -> { @topic.save }
  end

  def change_topic
    @group = DiscussionGroup.find(params[:group_id])
    @group.topic.content = params[:topic]
    @group.save
  end
end