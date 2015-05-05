require('rspec')
require('patient')
require('doctor')
require('pg')
require('pry')

DB = PG.connect({:dbname => 'test_clinic'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM patients *;")
    DB.exec("DELETE FROM doctors *;")
  end
end
