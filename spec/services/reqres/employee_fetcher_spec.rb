# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Reqres::EmployeeFetcher do
  context "#all" do
    it "fetches the amount of employees per_page and on page" do
      employees = described_class.new(page: 1, per_page: 6)

      expect(employees.all.count).to eq(6)
    end

    it "fetches different employees for different pages" do
      employees = described_class.new

      first_page_employees = employees.page(1).all
      second_page_employees = employees.page(2).all

      expect(first_page_employees).not_to equal(second_page_employees)
    end

    it "returns an empty array if page don't exist" do
      employees = described_class.new(page: 999)

      expect(employees.all).to eq([])
    end
  end

  context "#find" do
    it "fetches a single employee by id" do
      employees = described_class.new

      desired_employee = employees.find(1)

      expect(desired_employee["first_name"]).to eq("George")
    end

    it "returns nothing if no employees matches the given id" do
      employees = described_class.new

      desired_employee = employees.find(999)

      expect(desired_employee).to eq(nil)
    end
  end

  context "#total_pages" do
    it "fetches the total number of pages" do
      employees = described_class.new(per_page: 999)
      
      expect(employees.total_pages).to eq(1)
    end
  end
end
