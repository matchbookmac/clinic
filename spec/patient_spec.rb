require('spec_helper')

describe(Patient) do
  describe('.all') do
    it('will return an empty array of Patients when there are none') do
      expect(Patient.all()).to(eq([]))
    end
  end

  describe('#save') do
    it('will save a user inputed patient to the database') do
      patient = Patient.new({:name => "Hank Hill", :doctor_id => nil, :birthday => "1950/04/14", :id => nil})
      patient.save()
      expect(Patient.all()).to(eq([patient]))
    end
  end

  describe('#==') do
    it('will check if two patients are equal') do
      patient = Patient.new({:name => "Hank Hill", :doctor_id => nil, :birthday => "1950/04/14", :id => nil})
      patient_2 = Patient.new({:name => "Hank Hill", :doctor_id => nil, :birthday => "1950/04/14", :id => nil})
      expect(patient).to(eq(patient_2))
    end
  end

  describe('#delete') do
    it('will delete a patient from the database') do
      patient = Patient.new({:name => "Hank Hill", :doctor_id => nil, :birthday => "1950/04/14", :id => nil})
      patient.save()
      patient.delete()
      expect(Patient.all()).to(eq([]))
    end
  end

  describe('#update') do
    it('will update a patient\'s information') do
      patient = Patient.new({:name => "Hank Hill", :doctor_id => nil, :birthday => "1950/04/14", :id => nil})
      patient.save()
      patient.update({:name => 'Bobby Hill', :birthday => '1980/05/12'})
      expect(patient.name()).to(eq('Bobby Hill'))
      expect(patient.birthday()).to(eq('1980/05/12'))
    end
  end

  describe('#doctor') do
    it('will return the doctor_id of a specific patient') do
      doctor = Doctor.new({:name => 'Bob', :id => nil})
      doctor.save()
      patient = Patient.new({:name => "Hank Hill", :doctor_id => doctor.id(), :birthday => "1950/04/14", :id => nil})
      patient.save()
      expect(patient.doctor()).to(eq(doctor))
    end
  end
end
