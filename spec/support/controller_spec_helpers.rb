module ControllerSpecHelpers  
  def json_response
    JSON.parse(response.body)
  end
end

RSpec.configure do |config|
  config.include ControllerSpecHelpers, type: :controller
  config.include ControllerSpecHelpers, type: :request
end