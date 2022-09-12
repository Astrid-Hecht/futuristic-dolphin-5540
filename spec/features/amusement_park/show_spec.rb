require 'rails_helper'

RSpec.describe 'park show' do
  before :each do
    @park = AmusementPark.create(name: 'Seven Flags', admission_cost: 80)
    @park_2 = AmusementPark.create(name: 'WisneyDorld', admission_cost: 200)
    @ride_1 = @park.rides.create(name: "Big Twister", thrill_rating: 5, open: true)
    @ride_2 = @park.rides.create(name: "Afternoon Breeze", thrill_rating: 10, open: true)
    @ride_3 = @park.rides.create(name: "Batman Swing", thrill_rating: 3, open: false)
    @ride_4 = @park_2.rides.create(name: "Teacups", thrill_rating: 1, open: true)
    visit "/parks/#{@park.id}"
  end

  it 'shows park info' do
    within "#info" do 
      expect(page).to have_content(@park.name)
      expect(page).to have_content(@park.admission_cost)

      expect(page).to_not have_content(@park_2.name)
      expect(page).to_not have_content(@park_2.admission_cost)
    end
  end

  it 'lists names of all rides in the park' do
    within "#list" do
      expect(page).to have_content(@ride_1.name)
      expect(page).to have_content(@ride_2.name)
      expect(page).to have_content(@ride_3.name)

      expect(page).to_not have_content(@ride_4.name)
    end
  end

  it 'and in alphabetical order' do
    within "#list" do
      expect(@ride_2.name).to appear_before(@ride_3.name)
      expect(@ride_3.name).to appear_before(@ride_1.name)
    end
  end

  it 'shows total average thrill rating for all rides' do
    within '#avg_rating' do
      expect(page).to have_content(Ride.avg_thrill)
    end
  end
end