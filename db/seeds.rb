# encoding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

courses = [
	["MO01","Métodos de optimización","1.0","curso de optimización","1","1","1"],
	["CPS01","Criptografía y protocolos de seguridad","1.0","Manejar el concepto y la operación de protocolos de seguridad.","3","1","1"],
	["RC01","Redes de comunicación","1.0","Curso de redes y comunicación","1","1","1"]
]

courses.each do |code, name, version, description, category_id, career_id, department_id|
  Course.create( code: code, name: name, version: version, description: description, category_id: category_id, career_id: career_id, department_id: department_id)
end

categories = ["Electivo", "Obligatorio", "Optativo"]

categories.each do |name|
	Category.create(name: name)
end

careers = ["Ingeniería Civil Informática", "Ingeniería Ejecución Informática"]

careers.each do |name|
	Career.create(name: name)
end

metadata = ["General","Life cycle","Educational","Rights"]

metadata.each do |name|
	MetadataSchema.create(name: name)
end