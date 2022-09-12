class Mechanic < ApplicationRecord
  has_many :mechanic_rides
  has_many :rides, through: :mechanic_rides

  def self.avg_exp
    all.average(:exp)
  end

  def thrill_sort
    rides.where('open = ?', true).order(thrill_rating: :desc)
  end
end