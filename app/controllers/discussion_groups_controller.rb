class DiscussionGroupsController < ApplicationController
  before_filter :load_group
  before_filter :ensure_admin!, :except => [:show]
  before_filter :authenticate_user!
  before_filter :ensure_valid_participant_only!

  def show
    @messages = @group.messages.limit(50).order_by([:created_at, :desc]).reverse
  end

  def admin
    @groups = DiscussionGroup.all
  end

  def manage
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
    @group.update_attributes(params[:discussion_group])
    redirect_with_message notice: 'Successfully Updated',
                          alert: 'Failed to Update group',
                          if: -> { @group.save }
  end

  def edit
    @topic = @group.topic || Topic.new
  end

  def new
    @group = DiscussionGroup.new
    @topic = Topic.new
  end

  def remove_user
    @user = User.find(params[:user_id])
    @group.users.delete(@user)
  end

  def add_user
    @user = User.find(params[:user_id])
    @group.users << @user
  end

  def destroy
    redirect_with_message notice: "Successfully created new group",
                          alert: 'Failed to remove group',
                          if: -> { @group.destroy }
  end

  private
    def ensure_valid_participant_only!
      if @group.cannot_join?(current_user)
        redirect_to root_path, alert: 'You are not allowed to access this group.'
      end
    end

    def load_group
      @group = DiscussionGroup.find(params[:id]) if params[:id].present?
    end

end
