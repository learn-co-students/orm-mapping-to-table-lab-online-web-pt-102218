class Student
  attr_accessor :name, :grade
  attr_reader :id
  #this is an attr_reader because you are not setting it- the database is. 
  
  def initialize (name, grade, id = nil)
    @name = name
    @grade = grade 
    @id = id 
  end 
  
  def self.create_table
    sql =  <<-SQL 
      CREATE TABLE IF NOT EXISTS students (
        id INTEGER PRIMARY KEY, 
        name TEXT, 
        grade INTEGER
        )
    SQL
    DB[:conn].execute(sql) 
  end 
  
  def self.drop_table 
    sql =  <<-SQL 
      DROP TABLE students
    SQL
    DB[:conn].execute(sql) 
  end 
  
  
  def save 
    sql = <<-SQL 
      INSERT INTO students(name, grade) VALUES (?, ?)
    SQL
    DB[:conn].execute(sql, self.name, self.grade)
    #here you are saving the instance of the class- receiver 
    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
    #above saves an instance of Student to the database... INCLUDING the id 
  end 
  
  def self.create(name:, grade:) 
    #here it takes in a hash of attributes- using metaprogramming 
    new_student = Student.new(name, grade)
    new_student.save
    new_student 
    
  end 
  
end
