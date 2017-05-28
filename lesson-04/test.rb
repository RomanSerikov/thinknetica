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

train1 = PassengerTrain.new(number: 777)
train2 = PassengerTrain.new(number: 123)
train3 = CargoTrain.new(number: 888)

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

vagon1 = CargoVagon.new
vagon2 = CargoVagon.new
vagon3 = CargoVagon.new

puts "========================="

train4 = CargoTrain.new(number: 456)
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

puts "===== Finish testing ====="
