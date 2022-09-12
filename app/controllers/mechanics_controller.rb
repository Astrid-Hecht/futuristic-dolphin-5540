class MechanicsController < ApplicationController
  def index
    @mechs = Mechanic.all
  end

  def show
    @mech = Mechanic.find(params[:id])
  end

  def update
    mechanic = Mechanic.find(params[:id])
    MechanicRide.create(mechanic_id: params[:id], ride_id: params[:add_ride_id])
    mechanic.update(mechanic_params)

    redirect_to "/mechanics/#{mechanic.id}"
  end

  private
  def mechanic_params
    params.permit(:id, :name, :exp)
  end
end