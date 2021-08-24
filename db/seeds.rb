require 'faker'

puts "Cleaning the DB"


puts "clearing students"
Student.destroy_all
puts "Students cleared"

puts "clearing classes"
Kurasu.destroy_all
puts "Classes cleared"

puts "clearing the events"
Event.destroy_all
puts "Events cleared"

puts "clearing the users"
User.destroy_all
puts "User cleared"

puts "Creating new users"
sae = User.create!(
  email: "sae@me.com",
  password: 123456,
  name: "Sae",
  teacher: true
)

quill = User.create!(
  email: "quill@me.com",
  password: 123456,
  name: "Quill",
  teacher: false
)

viddy = User.create!(
  email: "viddy@me.com",
  password: 123456,
  name: "Viddy",
  teacher: false
)

kevin = User.create!(
  email: "kevin@me.com",
  password: 123456,
  name: "Kevin",
  teacher: true
)
puts "Users created"

puts "creating classes"
classonea = Kurasu.create(
  name: "1-A",
  class_year: 1,
  user_id: sae.id
)

classoneb = Kurasu.create(
  name: "1-B",
  class_year: 1,
  user_id: sae.id
)

classtwoa = Kurasu.create(
  name: "2-A",
  class_year: 2,
  user_id: sae.id
)

classtwob = Kurasu.create(
  name: "2-B",
  class_year: 2,
  user_id: sae.id
)
puts "Classes created"

puts "Creating our target student"
ren = Student.create!(
  first_name: "Ren",
  last_name: "Kitano",
  birthday: "2015-08-24",
  student_number: 1,
  kurasu_id: classonea.id,
  user_id: sae.id
)

puts "Creating 9 students for class 1-A"
counter = 1
9.times do
  counter += 1
  student = Student.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    birthday: Faker::Date.between(from: '2015-01-01', to: '2015-12-31'),
    student_number: counter,
    kurasu_id: classonea.id,
    user_id: sae.id
  )
  puts "Created #{student.id}"
end
puts "students created"

puts "Creating 10 students for class 1-B"
counter = 10
10.times do
  counter += 1
  student = Student.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    birthday: Faker::Date.between(from: '2015-01-01', to: '2015-12-31'),
    student_number: counter,
    kurasu_id: classoneb.id,
    user_id: sae.id
  )
  puts "Created #{student.id}"
end
puts "students created"

puts "Creating 10 students for class 2-A"
counter = 20
10.times do
  counter += 1
  student = Student.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    birthday: Faker::Date.between(from: '2014-01-01', to: '2014-12-31'),
    student_number: counter,
    kurasu_id: classtwoa.id,
    user_id: sae.id
  )
  puts "Created #{student.id}"
end
puts "students created"

puts "Creating 10 students for class 2-B"
counter = 30
10.times do
  counter += 1
  student = Student.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    birthday: Faker::Date.between(from: '2015-01-01', to: '2015-12-31'),
    student_number: counter,
    kurasu_id: classtwob.id,
    user_id: sae.id
  )
  puts "Created #{student.id}"
end
puts "students created"
