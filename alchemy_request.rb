require 'net/http'
require 'net/https'
require 'json'

# Alchemy_Entities (POST )
def send_request
  uri = URI('https://gateway-a.watsonplatform.net/calls/url/URLGetRankedNamedEntities')

  # Create client
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true
  http.verify_mode = OpenSSL::SSL::VERIFY_PEER
  dict = {
            "url" => "http://feeds.inc.com/~r/home/updates/~3/RxwIl2EOmEA/story01.htm",
            "outputMode" => "json",
            "maxRetrieve" => 10,
            "quotations" => 1
        }
  body = JSON.dump(dict)

  # Create Request
  req =  Net::HTTP::Post.new(uri)
  # Add headers
  req.add_field "Content-Type", "application/json; charset=utf-8"
  # Set body
  req.body = body®®

  # Fetch Request
  res = http.request(req)
  puts "Response HTTP Status Code: #{res.code}"
  puts "Response HTTP Response Body: #{res.body}"
rescue StandardError => e
  puts "HTTP Request failed (#{e.message})"
end
