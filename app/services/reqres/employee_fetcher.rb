module Reqres
  class EmployeeFetcher
    include HTTParty
    self.base_uri "https://reqres.in/api"

    def initialize(page: 1, per_page: 6)
      @options = { query: { page:, per_page: } }
    end

    def all
      response = self.class.get("/users", @options)
      employees = handle_response(response)

      employees.map { |employee| OpenStruct.new(employee) }
    end

    def find(id)
      response = self.class.get("/users/#{id}", @options)
      employee = handle_response(response)

      OpenStruct.new(employee)
    rescue
      nil
    end

    def page(page = 1)
      @options = { query: { page: page } }

      self
    end

    private
  
    def handle_response(response)
      if response.success?
        response["data"]
      else
        raise "Error fetching employees: #{response.code} - #{response.message}"
      end
    end
  end
end
