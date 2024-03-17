# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Employees Show page navigation', type: :system do
  context 'User wants to visualize an employee profile' do
    it 'and tries to click on a user row', :vcr, :aggregate_failures do      
      VCR.use_cassette('employees_show_page_navigation') do
        visit root_path(page: 1)

        within 'table' do
          expect(page).to have_content('George Bluth')
          expect(page).to have_content('george.bluth@reqres.in')
        end

        click_on "George Bluth"

        within '.card' do
          expect(page).to have_content('George Bluth')
          expect(page).to have_content('Bio')
          expect(page).to have_content('Highlights')
        end
      end
    end
  end
end
