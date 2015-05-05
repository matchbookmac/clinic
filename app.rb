require('pg')
require('sinatra')
require('sinatra/reloader')
require('./lib/doctor')
require('./lib/patient')
also_reload('lib/**/*.rb')

#DB = PG.connect({:dbname => 'clinic'})

get('/') do
  erb(:index)
end

get('/admin') do
  @doctors = Doctor.all()
  erb(:admin)
end

get('/doctors') do
  erb(:doctors)
end

get('/doctor/:id') do
  @doctor = Doctor.find(params.fetch('id'))
  @patients = @doctor.patients()
  erb(:doctor)
end

get('/patient') do
  @doctors = Doctor.all()
  erb(:patient)
end

post('/admin') do
  @name = params.fetch('name')
  @doctor = Doctor.new({:name => @name, :id => nil})
  @doctor.save()
  @doctors = Doctor.all()
  erb(:admin)
end
