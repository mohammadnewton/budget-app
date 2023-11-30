class EntitiesController < ApplicationController
  before_action :authenticate_user!

  def index
    @group = Group.find(params[:group_id])
    @entities = @group.entities.order(created_at: :desc)
    @total_amount = @group.entities.sum(:amount)
  end

  def new
    @group = Group.find(params[:group_id])
    @entity = Entity.new
  end

  def create
    @group = Group.find(params[:group_id])
    @entity = @group.entities.build(entity_params)

    if @entity.save
      redirect_to group_entities_path(@group), notice: 'Transaction created successfully.'
    else
      render :new
    end
  end

  private

  def entity_params
    params.require(:entity).permit(:name, :amount, group_ids: [])
  end
end
