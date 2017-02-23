# JSON Parsing example
require "rubygems"
require "json"

print "Vendor ID"
id = gets

# Read JSON from a file, iterate over objects
file = File.read("/data/companies_details/#{id}.json")
data_hash = JSON.parse(file)

urls = data_hash['stories']
puts urls
