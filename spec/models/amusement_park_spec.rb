require 'rails_helper'

RSpec.describe AmusementPark, type: :model do
  describe 'relationships' do
    it { should have_many(:rides) }
  end

  describe 'instance methods' do
    before :each do 
      @park = AmusementPark.create(name: 'Seven Flags', admission_cost: 80)
      @ride_1 = @park.rides.create(name: "Big Twister", thrill_rating: 5, open: true)
      @ride_2 = @park.rides.create(name: "Afternoon Breeze", thrill_rating: 10, open: true)
      @ride_3 = @park.rides.create(name: "Batman Swing", thrill_rating: 3, open: false)
    end

    it '#avg_thrill' do 
      expect(@park.avg_thrill).to eq(((@ride_1.thrill_rating + @ride_2.thrill_rating + @ride_3.thrill_rating).to_f / 3).round(2))
    end

    it '#alpha_order' do 
      expect(@park.alpha_order).to eq([@ride_2, @ride_3, @ride_1])
    end
  
  end
end