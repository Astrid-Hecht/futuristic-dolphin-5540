class MechanicsController < ApplicationController
  def index
    @mechs = Mechanic.all
  end

  def show
    @mech = Mechanic.find(params[:id])
  end
end