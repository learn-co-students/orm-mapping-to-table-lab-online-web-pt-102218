class Student
  
  attr_accessor :name, :grade
  
  attr_reader :id

  def initialize(name, grade, id = nil)
    @name = name
    @grade = grade
    @id = id
  end
  
  def self.create_table
    sql = <<-anything
    CREATE TABLE students
    (id INTEGER PRIMARY KEY,
    name TEXT,
    grade TEXT)
    anything
    DB[:conn].execute(sql)
    
  end
  
  def self.drop_table
    sql = <<-anything
    DROP TABLE students
    anything
    DB[:conn].execute(sql)
  end
  
  def save
    sql = <<-anything
    INSERT INTO students
    (name, grade)
    VALUES (?, ?)
    anything
    DB[:conn].execute(sql, self.name, self.grade)
    @id =DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
  end
  
  def self.create(name:, grade:) 
    student = Student.new(name, grade)
    student.save
    student
 
  end
    
    
  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]  
  
end
