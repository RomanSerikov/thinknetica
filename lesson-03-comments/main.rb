require_relative 'route'
require_relative 'station'
require_relative 'train'

puts "===== Start testing ===== "

st1 = Station.new("Moscow")
st2 = Station.new("Saint-Petersburg")
st3 = Station.new("Tula")
st4 = Station.new("Kolomna")
st5 = Station.new("Tver")

puts "========================="

route1 = Route.new(st1, st2)

puts "========================="

route1.add_station(st3)
route1.add_station(st4)
route1.show_all_stations

puts "========================="

route1.delete_station(st3)
route1.show_all_stations

puts "========================="

train1 = Train.new(777, :pass, 10)
train2 = Train.new(123, :pass, 16)
train3 = Train.new(888, :cargo, 20)

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

train4 = Train.new(456, :pass, 15)
puts "Current speed: #{train4.speed}"
train4.speed_up
train4.speed_up
train4.speed_up
puts "Current speed: #{train4.speed}"
train4.speed_down
puts "Vagons: #{train4.vagons}"
train4.add_vagon
train4.stop
train4.add_vagon
train4.add_vagon
puts "Vagons: #{train4.vagons}"
train4.remove_vagon
puts "Vagons: #{train4.vagons}"

puts "========================="

route1.add_station(st3)
route1.add_station(st5)
route1.show_all_stations
train4.take_route(route1)
puts "Train #{train4.number}, current station: #{train4.current_station.title}."
train4.move_next_station
puts "Train #{train4.number}, current station: #{train4.current_station.title}."
train4.move_next_station
puts "Train #{train4.number}, current station: #{train4.current_station.title}."
train4.move_back_station
train4.move_back_station
train4.move_back_station





