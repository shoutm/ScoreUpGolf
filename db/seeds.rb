# encoding: UTF-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

GolfField.delete_all
field1 = GolfField.create(name: "ゴルフ場1")
field2 = GolfField.create(name: "ゴルフ場2")

GolfCource.delete_all
cource1 = GolfCource.create(name: "コース1-1", golf_field_id: field1.id)
cource2 = GolfCource.create(name: "コース1-2", golf_field_id: field1.id)
cource3 = GolfCource.create(name: "コース2-1", golf_field_id: field2.id)

GolfHole.delete_all
hole1 = GolfHole.create(golf_cource_id: cource1.id, hole_no: 1, par: 5, yard: 360)
hole2 = GolfHole.create(golf_cource_id: cource1.id, hole_no: 2, par: 3, yard: 360)
hole3 = GolfHole.create(golf_cource_id: cource1.id, hole_no: 3, par: 4, yard: 360)
hole4 = GolfHole.create(golf_cource_id: cource2.id, hole_no: 4, par: 5, yard: 360)
hole5 = GolfHole.create(golf_cource_id: cource2.id, hole_no: 5, par: 3, yard: 360)
hole6 = GolfHole.create(golf_cource_id: cource2.id, hole_no: 6, par: 4, yard: 360)
