class MessagesController < ApplicationController
  before_filter :authenticate_user!


  def get_messages_by_topic
    @topic = Topic.find(params[:topic_id])
  end

  def create
    return nil if params[:message][:content].blank?
    @message = Message.new(params[:message])
    @message.user = current_user

    group = DiscussionGroup.find(params[:message][:discussion_group_id])

    if group and current_user.discussion_groups.include?(group)
      @message.discussion_group = group
      @message.topic = group.topic
    end

    @message.save

  end
end
