class DiscussionGroupsController < ApplicationController
  before_filter :ensure_admin!, :except => [:show]
  before_filter :authenticate_user!

  def show
    @group = DiscussionGroup.find(params[:id])
    @messages = @group.messages.limit(50).order_by([:created_at, :desc]).reverse
  end

  def admin
    @groups = DiscussionGroup.all
  end

  def manage
    @group = DiscussionGroup.find(params[:id])
    @permitted_users = @group.users
    @other_users = User.all - @group.users
  end

  def create
    @group = DiscussionGroup.new(params[:discussion_group])
    redirect_with_message notice: 'Successfully create new group',
                          alert: 'Failed to create new group',
                          if: -> { @group.save }
  end

  def update
    @group = DiscussionGroup.find(params[:id])
    @group.update_attributes(params[:discussion_group])
    redirect_with_message notice: 'Successfully Updated',
                          alert: 'Failed to Update group',
                          if: -> { @group.save }
  end

  def edit
    @group = DiscussionGroup.find(params[:id])
    @topic = @group.topic || Topic.new
  end

  def new
    @group = DiscussionGroup.new
    @topic = Topic.new

  end

  def remove_user
    @group = DiscussionGroup.find(params[:id])
    @user = User.find(params[:user_id])
    @group.users.delete(@user)
  end

  def add_user
    @group = DiscussionGroup.find(params[:id])
    @user = User.find(params[:user_id])
    @group.users << @user
  end

  def destroy
    @group = DiscussionGroup.find(params[:id])
    redirect_with_message notice: "Successfully created new group",
                          alert: 'Failed to remove group',
                          if: -> { @group.destroy }
  end

end
