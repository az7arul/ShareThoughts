class DiscussionGroupsController < ApplicationController
  before_filter :ensure_admin!, :except => [:show]
  before_filter :authenticate_user!

  def show
    @group = DiscussionGroup.find(params[:id])
    @messages = @group.messages.limit(5).order_by([:created_at, :desc]).reverse
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
    @group = DiscussionGroup.create!(params[:discussion_group])
    redirect_to root_path
  end

  def new
    @group = DiscussionGroup.new
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

  private

  def ensure_admin!
    redirect_to root_path unless current_user.is_admin?
  end

end
