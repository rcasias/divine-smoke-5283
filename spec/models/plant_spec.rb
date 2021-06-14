require 'rails_helper'

RSpec.describe Plant do
  describe 'relationships' do
    it { should have_many(:varieties) }
    it { should have_many(:plots).through(:varieties) }
  end
end
