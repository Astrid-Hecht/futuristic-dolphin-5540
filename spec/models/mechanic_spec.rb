require 'rails_helper'

RSpec.describe Mechanic, type: :model do
  xdescribe 'relationships' do
    it { should have_many(:rides) }
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
end