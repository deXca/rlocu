require 'yaml'
module Rlocu
  
  class << self

    def config!
      @api_key = <%= ENV["LOCU_API_KEY"] %>
      @http_base = 'https://api.locu.com/v1_0/'
    end

    def api_key
      @api_key
    end

    def http_base
      @http_base
    end

  end
  
  config!
  
end
