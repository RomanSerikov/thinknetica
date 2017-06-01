require_relative 'company_name'
  
class Vagon
  include CompanyName
  attr_reader :type
end
