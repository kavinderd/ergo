require 'faraday'
module HttpResponse

  def self.post(url:,endpoint:, data:)
    conn = Faraday.new(url: url) do |faraday|
      faraday.request :url_encoded
      faraday.response :logger
      faraday.adapter Faraday.default_adapter
    end
    conn.post do |req|
      req.url endpoint
      req.body = "#{data}"
    end  
  end

end
