class DiscussionGroupsController < ApplicationController
  before_filter :authenticate_user!

  def show
    @group = DiscussionGroup.find(params[:id])
    @messages = @group.messages.limit(5).order_by([:created_at, :desc ]).reverse
  end
end
