class DashboardController < ApplicationController

  before_filter :authenticate_user!

  def index
    @topics = Topic.all
    @topic = @topics.first
    @groups = if current_user.is_admin?
      DiscussionGroup.all
    else
      current_user.discussion_groups
    end
  end
end
