module CompanyName
  attr_accessor :company_name

  def add_company(company:)
    self.company_name = company
    puts "Company name #{company} added."
  end
end