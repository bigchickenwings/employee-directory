# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Reqres::EmployeeFetcher do
  context "#all" do
    it "fetches the amount of employees per_page and on page", :vcr do
      VCR.use_cassette('employee_fetcher_all_page_one') do
        employees = described_class.new(page: 1, per_page: 6)

        expect(employees.all.count).to eq(6)
      end
    end

    it "returns an empty array if page don't exist", :vcr do
      VCR.use_cassette('employee_fetcher_all_page_does_not_exist') do
        employees = described_class.new(page: 999)

        expect(employees.all).to eq([])
      end
    end
  end

  context "#find" do
    it "fetches a single employee by id", :vcr do
      VCR.use_cassette('employee_fetcher_find_first_employee') do
        employees = described_class.new

        desired_employee = employees.find(1)

        expect(desired_employee["first_name"]).to eq("George")
      end
    end

    it "returns nothing if no employees matches the given id", :vcr do
      VCR.use_cassette('employee_fetcher_find_no_employee') do
        employees = described_class.new

        desired_employee = employees.find(999)

        expect(desired_employee).to eq(nil)
      end
    end
  end

  context "#total_pages" do
    it "fetches the total number of pages", :vcr do
      VCR.use_cassette('employee_fetcher_total_pages') do
        employees = described_class.new(per_page: 999)
        
        expect(employees.total_pages).to eq(1)
      end
    end
  end
end
