class MessagesController < ApplicationController
  before_filter :authenticate_user!


  def create
    @message = Message.new(params[:message])
    @message.user = current_user

    group = DiscussionGroup.find(params[:message][:discussion_group_id])

    if group and current_user.discussion_groups.include?(group)
      @message.discussion_group = group
      @message.topic = group.topic
    end

    @message.save || raise("Invalid parameters")

  end
end
