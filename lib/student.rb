class Student

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]  
  attr_reader :id
  attr_accessor :name, :grade
  
  def initialize(name, grade, id = nil)
    @name = name
    @grade = grade
    @id = id
  end
  
  def self.create_table
    DB[:conn].execute <<-SQL
                            CREATE TABLE IF NOT EXISTS students (
                              id INTEGER PRIMARY KEY,
                              name TEXT,
                              grade TEXT);
                          SQL
  end
  
  def self.drop_table
    DB[:conn].execute("DROP TABLE students;")
  end
  
  def save
    insert = <<-SQL
                INSERT INTO students(name, grade)
                VALUES (?, ?);
              SQL
    DB[:conn].execute(insert, self.name, self.grade)
    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students;")[0][0]
  end
  
  def self.create(att_hash)
    new_student = Student.new(att_hash[:name], att_hash[:grade])
    new_student.save
    new_student
  end
  
end
