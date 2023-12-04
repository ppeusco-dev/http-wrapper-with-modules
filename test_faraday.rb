# frozen_string_literal: true

require "faraday"

# Solo ejecuta este bloque de código para aislar el problema
url = "https://api.example.com"
headers = { "Authorization" => "Bearer 1234567890" }
connection = Faraday.new(url: url, headers: headers) do |conn|
  conn.adapter Faraday.default_adapter
end

# Imprime la URL construida
puts "Built URL: #{connection.url_prefix}"
puts connection.inspect
