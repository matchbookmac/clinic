class Patient

  attr_reader(:id, :name, :doctor_id, :birthday)

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
    @birthday = attributes.fetch(:birthday)
    @doctor_id = attributes.fetch(:doctor_id)
  end

  define_singleton_method(:all) do
    returned_patients = DB.exec("SELECT * FROM patients;")
    patients = []
    returned_patients.each() do |patient|
      id = patient.fetch("id").to_i()
      name = patient.fetch("name")
      doctor_id = patient.fetch('doctor_id')
      birthday = patient.fetch("birthday")
      patients.push(Patient.new({:id => id, :name => name, :doctor_id => doctor_id, :birthday => birthday}))
    end
    patients
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO patients (name, birthday) VALUES ('#{@name}', '#{@birthday}') RETURNING id;")
    @id = result.first().fetch('id').to_i()
  end

  define_method(:delete) do
    @id = self.id()
    DB.exec("DELETE FROM patients WHERE id = #{@id}")
  end

  define_method(:update) do |attributes|
    @id = self.id()
    @name = attributes.fetch(:name)
    @birthday = attributes.fetch(:birthday)
    DB.exec("UPDATE patients SET name = '#{@name}' WHERE id = #{@id}")
    DB.exec("UPDATE patients SET birthday = '#{@birthday}' WHERE id = #{@id}")
  end

  define_method(:doctor) do
    @doctor_id = self.doctor_id()
    result = DB.exec("SELECT * FROM doctors WHERE id = #{@doctor_id};")
    name = result.first().fetch('name')
    doctor = Doctor.new({:id => @doctor_id, :name => name})
  end

  define_method(:==) do |patient|
    self.name().==(patient.name()).&(self.id().==(patient.id()))
  end


end
