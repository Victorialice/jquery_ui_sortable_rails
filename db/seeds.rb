# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
if Admin.count == 0
admin = Admin.new
admin.name =  "admin" 
  admin.password =  "asdfasdf" 
  admin.save
  #admpassword_confirmation: "asdfasdf") 
end
