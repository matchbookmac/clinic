require('spec_helper')

describe(Doctor) do
  describe('.all') do
    it('will return an empty array of all doctors') do
      expect(Doctor.all()).to(eq([]))
    end
  end

  describe('#save') do
    it('will save a doctor to the database') do
      doctor = Doctor.new({:name => 'Bob', :id => nil})
      doctor.save()
      expect(Doctor.all()).to(eq([doctor]))
    end
  end

  describe('#==') do
    it('will determine if two doctors are equivalent') do
      doctor = Doctor.new({:name => 'Bob', :id => nil})
      doctor_2 = Doctor.new({:name => 'Bob', :id => nil})
      expect(doctor).to(eq(doctor_2))
    end
  end

  describe('#delete') do
    it('will delete a doctor from the database') do
      doctor = Doctor.new({:name => 'Bob', :id => nil})
      doctor.save()
      doctor.delete()
      expect(Doctor.all()).to(eq([]))
    end
  end

  describe('#update') do
    it('will update a doctor\'s information') do
      doctor = Doctor.new({:name => 'Bob', :id => nil})
      doctor.save()
      doctor.update({:name => 'Robert Hill'})
      expect(doctor.name()).to(eq('Robert Hill'))
    end
  end

  describe('#add_patient') do
    it('will add a patient to the doctor\'s patient list') do
      doctor = Doctor.new({:name => 'Bob', :id => nil})
      doctor.save()
      patient = Patient.new({:name => "Hank Hill", :doctor_id => doctor.id(), :birthday => "1950/04/14", :id => nil})
      patient.save()
      doctor.add_patient(patient)
      expect(patient.doctor_id).to(eq(doctor.id()))
    end
  end
end
