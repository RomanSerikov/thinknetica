puts "===== Start testing ====="
st1 = Station.new(title: "Moscow")
st2 = Station.new(title: "Saint-Petersburg")
st3 = Station.new(title: "Tula")
st4 = Station.new(title: "Kolomna")
st5 = Station.new(title: "Tver")

puts "========================="

route1 = Route.new(start: st1, finish: st2)

puts "========================="

route1.add_station(st3)
route1.add_station(st4)
route1.show_all_stations

puts "========================="

route1.delete_station(st3)
route1.show_all_stations

puts "========================="

train1 = PassengerTrain.new(number: "777-33")
train2 = PassengerTrain.new(number: "123-11")
train3 = CargoTrain.new(number: "777-12")

puts "========================="

st5.take_train(train1)
st5.take_train(train2)
st5.take_train(train3)
st5.show_all_trains
st5.trains_by_type(:pass)

puts "========================="

st5.send_train(train3)
st5.show_all_trains

puts "========================="

vagon1 = CargoVagon.new(capacity: 500)
vagon2 = CargoVagon.new(capacity: 600)
vagon3 = CargoVagon.new(capacity: 700)

puts "========================="

train4 = CargoTrain.new(number: "456-33")
train5 = CargoTrain.new(number: "33333")
puts "Current speed: #{train4.speed}"
train4.speed_up
train4.speed_up
train4.speed_up
puts "Current speed: #{train4.speed}"
train4.speed_down
puts "Vagons: #{train4.vagons}"
train4.add_vagon(vagon1)
train4.stop
train4.add_vagon(vagon1)
train4.add_vagon(vagon2)
puts "Vagons: #{train4.vagons}"
train4.remove_vagon(vagon2)
puts "Vagons: #{train4.vagons}"

puts "========================="

route1.add_station(st3)
route1.add_station(st5)
route1.show_all_stations
train4.take_route(route1)
train4.move_next_station
train4.move_next_station
train4.move_back_station
train4.move_back_station
train4.move_back_station

puts "==== Lesson 5 testing ===="

train4.add_company(company: "Velaro")
puts train4.company_name
vagon1.add_company(company: "Siemens")
puts vagon1.company_name

puts "========================="

puts Station.all

puts "========================="

puts Train.find(number: "777-33").inspect
puts Train.find(number: "999").inspect

puts "========================="

puts "PassengerTrain instances:"
puts PassengerTrain.instances
puts "CargoTrain instances:"
puts CargoTrain.instances
puts "Station instances:"
puts Station.instances

puts "===== Finish testing ====="
