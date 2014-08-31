require 'yaml'
module Rlocu
  
  class << self

    def config!(api_key)
      @api_key = api_key
      @http_base = 'https://api.locu.com/v1_0/'
    end

    def api_key
      @api_key
    end

    def http_base
      @http_base
    end

  end
  
end
