begin
  if ENV['CODECLIMATE_REPO_TOKEN']
    require 'codeclimate-test-reporter'
    CodeClimate::TestReporter.start
  else
    require 'simplecov'
    SimpleCov.start { add_filter('/vendor/bundle/') }
  end
rescue LoadError
  # Ignore when testing with Ruby 1.8.7
end

RSpec.configure do |config|
  config.raise_errors_for_deprecations!
end
