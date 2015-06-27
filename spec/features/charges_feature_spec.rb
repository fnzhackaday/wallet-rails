require 'rails_helper'

feature 'stripe' do

 include ChargesHelper

  after do
    Warden.test_reset! 
  end

  context 'if the user can pay' do

    scenario 'fills in and submits stripe form', js: true, driver: :selenium do
      charge_helper
      expect(page).to have_content('you paid £ 75 for Campaign!')
    end
  end
end