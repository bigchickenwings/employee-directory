# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Employees Index page navigation', type: :system do
  context 'User is looking through the employees' do
    it 'and tries to navigate through pages', :vcr, :aggregate_failures do      
      VCR.use_cassette('employees_index_page_navigation') do
        visit root_path(page: 1)

        within 'table' do
          expect(page).to have_content('George Bluth')
          expect(page).to have_content('george.bluth@reqres.in')
        end

        click_on "2"

        within 'table' do
          expect(page).to have_content('Rachel Howell')
          expect(page).to have_content('rachel.howell@reqres.in')
        end
      end
    end
  end
end
