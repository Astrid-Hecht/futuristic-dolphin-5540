require 'rails_helper'

RSpec.describe 'mechanics show' do
  before :each do
    @park = AmusementPark.create(name: 'Seven Flags', admission_cost: 80)
    @mech_1 = Mechanic.create(name: 'Joey', exp: 10)
    @mech_2 = Mechanic.create(name: 'Kristy', exp: 25)
    @mech_3 = Mechanic.create(name: 'Bobert', exp: 7)
    @ride_1 = @park.rides.create(name: "Big Twister", thrill_rating: 5, open: true)
    @ride_2 = @park.rides.create(name: "Afternoon Breeze", thrill_rating: 10, open: true)
    @ride_3 = @park.rides.create(name: "Batman Swing", thrill_rating: 3, open: false)
    MechanicRide.create(mechanic_id: @mech_1.id, ride_id: @ride_1.id)
    MechanicRide.create(mechanic_id: @mech_1.id, ride_id: @ride_2.id)
    MechanicRide.create(mechanic_id: @mech_1.id, ride_id: @ride_3.id)

    visit "/mechanics/#{@mech_1.id}"
  end

  it 'shows mechanic info' do
    within "#info" do 
      expect(page).to have_content(@mech_1.name)
      expect(page).to have_content(@mech_1.exp)
    end
  end

  it 'lists names of all rides theyre working on' do
    within "#list" do
      expect(page).to have_content(@ride_1.name)
      expect(page).to have_content(@ride_2.name)
    end
  end

  it 'and doesnt list closed rides' do
    within "#list" do
      expect(page).to_not have_content(@ride_3.name)
    end
  end

  it 'lists rides in descending thrill order' do
    twister = find("#ride-#{@ride_1.id}")
    breeze = find("#ride-#{@ride_2.id}")
    expect(breeze).to appear_before(twister)
  end

  describe 'Add a Ride to a Mechanic' do 
    it 'I see a form to add a ride to their workload' do 
      expect(page).to have_form('Add a Ride to Mechanic')
    end

    it 'When I fill in form with a ride id and hit submit, its name now appears on the show page' do
      ride_4 = @park.rides.create(name: "Teacups", thrill_rating: 1, open: true)
      expect(page).to_not have_content(ride_4.name)

      fill_in 'Add a Ride to Mechanic', with: ride_4.id
      click_button 'Add'
      refresh
      expect(page).to have_current_path("/mechanics/#{@mech_1.id}")
      expect(page).to have_content(ride_4.name)
    end
  end
end