class Mechanic < ApplicationRecord
  def self.avg_exp
    all.average(:exp)
  end
end