class AmusementPark < ApplicationRecord
  has_many :rides

  def avg_thrill
    rides.average(:thrill_rating)
  end

  def alpha_order
    rides.order(:name)
  end
end
