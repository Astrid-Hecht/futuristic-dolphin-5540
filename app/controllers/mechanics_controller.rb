class MechanicsController < ApplicationController
  def index
    @mechs = Mechanic.all
  end
end