require 'rails_helper'

RSpec.describe Ride, type: :model do
  describe 'relationships' do
    it { should belong_to(:amusement_park) }
    it { should have_many(:mechanic_rides) }
    it { should have_many(:mechanics).through(:mechanic_rides) }
  end

  describe 'instance methods' do
    it 'can sort open rides by desc thrill rating' do
      @park = AmusementPark.create(name: 'Seven Flags', admission_cost: 80)
      @mech_1 = Mechanic.create(name: 'Joey', exp: 10)
      @ride_1 = @park.rides.create(name: "Big Twister", thrill_rating: 5, open: true)
      @ride_2 = @park.rides.create(name: "Afternoon Breeze", thrill_rating: 10, open: true)
      @ride_3 = @park.rides.create(name: "Batman Swing", thrill_rating: 3, open: false)
      MechanicRide.create(mechanic_id: @mech_1.id, ride_id: @ride_1.id)
      MechanicRide.create(mechanic_id: @mech_1.id, ride_id: @ride_2.id)
      MechanicRide.create(mechanic_id: @mech_1.id, ride_id: @ride_3.id)

      expect(@mech_1.rides.thrill_sort).to eq([@ride_2, @ride_1])
    end
  end
end