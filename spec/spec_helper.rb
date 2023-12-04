# frozen_string_literal: true

require "http/wrapper"
require "oj"
require "byebug"

RSpec.configure do |config|
  config.before(:each) do
    # Configuración de Faraday para pruebas
    allow(Faraday).to receive(:new).and_return(Faraday.new do |faraday|
      faraday.adapter :test do |_stub|
        faraday.adapter :typhoeus
      end
    end)
  end
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

Dir[File.join(File.dirname(__FILE__), "support/**/*.rb")].sort.each { |f| require f }
