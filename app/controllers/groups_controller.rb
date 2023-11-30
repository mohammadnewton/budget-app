class GroupsController < ApplicationController
  before_action :authenticate_user!

  def index
    @groups = current_user.groups
  end

  def show
    @group = Group.find(params[:id])
    @total_amount = @group.entities.sum(:amount)
  end

  def new
    @group = Group.new
  end

  def create
    @group = current_user.groups.build(group_params)

    if @group.save
      redirect_to groups_path, notice: 'Category created successfully.'
    else
      render :new
    end
  end

  private

  def group_params
    params.require(:group).permit(:name, :icon)
  end
end
