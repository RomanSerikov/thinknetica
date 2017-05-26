$stations = []
$trains   = []
$routes   = []

def wrong_command
  puts "Ошибка. Неверный номер команды."
end

def exit_programm
  puts "«Всего хорошего, и спасибо за рыбу!» — Дуглас Адамс"
  exit!
end

def show_commands
  commands = [
    "Выход",
    "Список команд",
    "Создать станцию",
    "Создать поезд",
    "Создать маршрут",
    "Редактировать маршрут",
    "Назначить маршрут",
    "Добавить вагон",
    "Отцепить вагон",
    "Переместить поезд",
    "Посмотреть список станций",
    "Посмотреть список поездов на станции"
  ]

  puts "==== Основные команды ===="
  commands.each.with_index(1) { |command, id| puts "#{id}: #{command}" }
end

def create_station
  puts "Введите название станции:"
  station_title = gets.chomp
  $stations << Station.new(title: station_title)
end

def create_train
  puts "Введите номер поезда:"
  train_number = gets.chomp.to_i

  puts "Выберите тип поезда:"
  puts "1: Пассажирский"
  puts "2: Грузовой"
  train_type = gets.chomp.to_i

  if train_type == 1
    $trains << PassengerTrain.new(number: train_number)
  elsif train_type == 2
    $trains << CargoTrain.new(number: train_number)
  else
    puts "Ошибка. Неверный тип поезда."
  end
end

def create_route 
  if $stations.size < 2
    puts "Ошибка. Необходимо сначала создать как минимум 2 станции."
  else

    puts "Выберите начальную станцию маршрута:"
    $stations.each_with_index do |station, id| 
      puts "#{id}: #{station} | #{station.title}"
    end
    start = $stations[gets.chomp.to_i]

    puts "Выберите конечную станцию маршрута:"
    curr_stations = $stations.select { |station| station != start }
    curr_stations.each_with_index do |station, id|
      puts "#{id}: #{station} | #{station.title}"
    end
    finish = curr_stations[gets.chomp.to_i]

    $routes << Route.new(start: start, finish: finish)
  end
end

def edit_route
  if $routes.empty?
    puts "Ошибка. Необходимо сначала создать маршрут."
  else
    puts "Выберите маршрут:"
    $routes.each_with_index do |route, id| 
      puts "#{id}: #{route} | #{route.stations.first.title}-#{route.stations.last.title}"
    end
    route = $routes[gets.chomp.to_i]

    puts "Станции, входящие в маршрут:"
    route.stations.each_with_index do |station, id|
      puts "#{id}: #{station} | #{station.title}"
    end

    puts "Выберите действие:"
    puts "1: Добавить станцию"
    puts "2: Удалить станцию"
    action = gets.chomp.to_i

    if action == 1

      puts "Выберите станцию, чтобы добавить её:"
      curr_stations = $stations.select { |station| !route.stations.include?(station) }
      curr_stations.each_with_index do |station, id|
        puts "#{id}: #{station} | #{station.title}"
      end
      station_to_add = curr_stations[gets.chomp.to_i]

      route.add_station(station_to_add)
    elsif action == 2
      puts "Выберите станцию, чтобы удалить её:"
      route.stations.each_with_index do |station, id| 
        puts "#{id}: #{station} | #{station.title}"
      end
      station_to_remove = route.stations[gets.chomp.to_i]

      route.delete_station(station_to_remove)
    else
      puts "Ошибка. Неверная команда."
    end
  end
end

def appoint_route
  if $trains.empty? || $routes.empty?
    puts "Ошибка. Необходимо сначала создать поезд и маршрут."
  else
    puts "Выберите поезд:"
    $trains.each_with_index do |train, id| 
      puts "#{id}: #{train} | #{train.number}"
    end
    train = $trains[gets.chomp.to_i]

    puts "Выберите маршрут:"
    $routes.each_with_index do |route, id| 
      puts "#{id}: #{route} | #{route.stations.first.title}-#{route.stations.last.title}"
    end
    route = $routes[gets.chomp.to_i]
    train.take_route(route)
  end
end

def add_vagon
  if $trains.empty?
    puts "Ошибка. Необходимо сначала создать поезд."
  else
    puts "Выберите поезд:"
    $trains.each_with_index do |train, id| 
      puts "#{id}: #{train} | Train number: #{train.number}"
    end
    train = $trains[gets.chomp.to_i]

    if train.type == :pass
      vagon = PassengerVagon.new
    elsif train.type == :cargo
      vagon = CargoVagon.new
    end

    train.add_vagon(vagon)
  end
end

def remove_vagon
  if $trains.empty?
    puts "Ошибка. Необходимо сначала создать поезд."
  else
    puts "Выберите поезд:"
    $trains.each_with_index do |train, id| 
      puts "#{id}: #{train} | #{train.number} | Vagons quantity: #{train.vagons.count}"
    end
    train = $trains[gets.chomp.to_i]

    if train.vagons.empty?
      puts "Ошибка. У этого поезда нет вагонов."
    else
      puts "Выберите вагон:"
      train.vagons.each_with_index do |vagon, id| 
        puts "#{id}: #{vagon}"
      end
      vagon = train.vagons[gets.chomp.to_i]
      train.remove_vagon(vagon)
    end
  end 
end

def move_train
  if $trains.empty?
    puts "Ошибка. Необходимо сначала создать поезд."
  else
    puts "Выберите поезд:"
    $trains.each_with_index do |train, id| 
      puts "#{id}: #{train} | #{train.number}"
    end
    train = $trains[gets.chomp.to_i]

    if train.route.nil?
      puts "Ошибка. У этого поезда нет маршрута."
    else
      puts "Поезд сейчас на станции #{train.current_station.title}."

      puts "Маршрут поезда:"
      train.route.stations.each_with_index do |station, id|
        puts "#{id}: #{station.title}"
      end

      puts "Выберите действие:"
      puts "1: Вперед по маршруту"
      puts "2: Назад по маршруту"
      action = gets.chomp.to_i

      if action == 1
        if train.current_station == train.route.stations.last
          puts "Ошибка. Поезд на конечной станции, движение вперед невозможно."
        else
          train.move_next_station
        end
      elsif action == 2
        if train.current_station == train.route.stations.first
          puts "Ошибка. Поезд на конечной станции, движение назад невозможно."
        else
          train.move_back_station
        end
      else
        puts "Ошибка. Неверная команда."
      end
    end
  end
end

def show_stations
  puts "Станции:"
  $stations.each_with_index do |station, id| 
    puts "#{id}: #{station} | title: #{station.title}"
  end
end

def show_trains_on_station
  puts "Выберите станцию, на которой хотите посмотреть поезда:"
  $stations.each_with_index do |station, id| 
    puts "#{id}: #{station} | title: #{station.title}"
  end
  $stations[gets.chomp.to_i].show_all_trains
end

show_commands

loop do
  puts "Выберите действие, введя номер команды. Список команд: <2>."
  action = gets.chomp.to_i

  case action
  when 0  then wrong_command
  when 1  then exit_programm
  when 2  then show_commands
  when 3  then create_station
  when 4  then create_train
  when 5  then create_route
  when 6  then edit_route
  when 7  then appoint_route
  when 8  then add_vagon
  when 9  then remove_vagon
  when 10 then move_train
  when 11 then show_stations
  when 12 then show_trains_on_station
  end
end
