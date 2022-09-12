require 'rails_helper'

RSpec.describe Mechanic, type: :model do
  describe 'relationships' do
    it { should have_many(:mechanic_rides) }
    it { should have_many(:rides).through(:mechanic_rides) }
  end

  describe 'class methods' do
    before :each do 
      @mech_1 = Mechanic.create(name: 'Joey', exp: 10)
      @mech_2 = Mechanic.create(name: 'Kristy', exp: 25)
      @mech_3 = Mechanic.create(name: 'Bobert', exp: 7)
    end

    it '#avg_exp' do 
      expect(Mechanic.avg_exp).to eq(((@mech_1.exp + @mech_2.exp + @mech_3.exp).to_f / 3).round(2))
    end
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

      expect(@mech_1.thrill_sort).to eq([@ride_2, @ride_1])
    end
  end
end