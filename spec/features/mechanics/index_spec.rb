require 'rails_helper'

RSpec.describe 'mechanics index' do
  before :each do
    @mech_1 = Mechanic.create(name: 'Joey', exp: 10)
    @mech_2 = Mechanic.create(name: 'Kristy', exp: 25)
    @mech_3 = Mechanic.create(name: 'Bobert', exp: 7)

    visit '/mechanics'
  end

  it 'has a header that says "All Mechanics" first' do
    header = find('#header')
    list = find('#mechanic-list')
    expect(header).to appear_before(list)
    within '#header' do
      expect(page).to have_content('All Mechanics')
    end
  end

  it 'lists names of all mechanics' do
    within '#mechanic-list' do
      expect(page).to have_content(@mech_1.name)
      expect(page).to have_content(@mech_2.name)
      expect(page).to have_content(@mech_3.name)
    end
  end

  it 'lists individual exp of all mechanics' do
    within '#mechanic-list' do
      expect(page).to have_content("Years of Experience: #{@mech_1.exp}")
      expect(page).to have_content("Years of Experience: #{@mech_2.exp}")
      expect(page).to have_content("Years of Experience: #{@mech_3.exp}")
    end
  end

  it 'shows total average years exp for all mechanics' do
    within '#exp' do
      expect(page).to have_content(Mechanic.avg_exp)
    end
  end
end
