require 'rails_helper'
require 'helpers/charges_helper.rb'

feature 'stripe' do

 include ChargesHelper

  after do
    Warden.test_reset! 
  end

  context 'if the user can pay' do
    before do
      visit('/charges/new')
    end

    scenario 'fills in and submits stripe form', js: true, driver: :selenium do
      charge_helper
      expect(page).to have_content('Thanks, you paid $5.00!')
    end
  end
end