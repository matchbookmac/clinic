class Doctor

  attr_reader(:id, :name)

  define_method(:initialize) do |attributes|
    @id = attributes.fetch(:id)
    @name = attributes.fetch(:name)
  end

  define_singleton_method(:all) do
    doctors = []
    returned_doctors = DB.exec("SELECT * FROM doctors;")
    returned_doctors.each() do |doctor|
      id = doctor.fetch('id').to_i()
      name = doctor.fetch('name')
      doctors.push(Doctor.new({:id => id, :name => name}))
    end
    doctors
  end

  define_method(:delete) do
    @id = self.id()
    DB.exec("DELETE FROM doctors WHERE id = #{@id}")
  end

  define_method(:update) do |attributes|
    @id = self.id()
    @name = attributes.fetch(:name)
    DB.exec("UPDATE doctors SET name = '#{@name}' WHERE id = '#{@id}'")
  end

  define_method(:save) do
    @name = name()
    result = DB.exec("INSERT INTO doctors (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch('id').to_i()
  end

  define_method(:add_patient) do |patient|
    @id = id()
    @patient_id = patient.id()
    DB.exec("UPDATE patients SET doctor_id = @id WHERE id = #{@patient_id}")
  end

  # define_method(:patients) do
  #   @patients = []
  #   @id = id()
  #   results = DB.exec("SELECT * FROM patients WHERE doctor_id = #{@id};")
  #   results.each() do |result|
  #     @id = result.fetch('id').to_i()
  #     @name = result.fetch('name')
  #     @doctor_id = result.fetch('doctor_id').to_i()
  #     @birthday = result.fetch('birthday')
  #     patient = Patient.new({:id => @id, :name => @name, :doctor_id => @doctor_id, :birthday => @bithday})
  #     patients.push(patient)
  #   end
  #   patients
  # end

  define_method(:==) do |other_doctor|
    name().==(other_doctor.name()).&(id().==(other_doctor.id()))
  end

end
