class Controller
  attr_accessor :stations, :trains, :routes

  def initialize
    @stations = []
    @trains   = []
    @routes   = []
  end

  def wrong_command
    puts 'Ошибка. Неверный номер команды.'
  end

  def exit_programm
    puts '«Всего хорошего, и спасибо за рыбу!» — Дуглас Адамс'
    exit!
  end

  def show_commands
    puts '==== Основные команды ===='
    File.open('commands.txt').each.with_index(1) { |command, id| puts "#{id}: #{command}" }
  end

  def create_station
    puts 'Введите название станции:'
    station_title = gets.chomp
    stations << Station.new(title: station_title)
    puts "Station created, title: #{station_title}."
  end

  def create_train
    puts 'Введите номер поезда:'
    train_number = gets.chomp

    puts "Выберите тип поезда: \n1: Пассажирский\n2: Грузовой"
    train_type = gets.chomp.to_i

    return puts 'Ошибка. Неверный тип поезда.' unless [1, 2].include?(train_type)

    if train_type == 1
      trains << PassengerTrain.new(number: train_number)
    elsif train_type == 2
      trains << CargoTrain.new(number: train_number)
    end

    puts "Train created. Number: #{train_number}, type: #{trains.last.type}."
  rescue
    puts 'Wrong number format. Try again.'
    retry
  end

  def create_route
    return puts 'Ошибка. Необходимо сначала создать как минимум 2 станции.' if stations.size < 2

    puts 'Выберите начальную станцию маршрута:'
    stations.each_with_index do |station, id|
      puts "#{id}: #{station} | #{station.title}"
    end
    start = stations[gets.chomp.to_i]

    puts 'Выберите конечную станцию маршрута:'
    curr_stations = stations.reject { |station| station == start }
    curr_stations.each_with_index do |station, id|
      puts "#{id}: #{station} | #{station.title}"
    end
    finish = curr_stations[gets.chomp.to_i]

    routes << Route.new(start: start, finish: finish)
    puts "Route created, from: #{start.title} to #{finish.title}."
  end

  def edit_route
    return puts 'Ошибка. Необходимо сначала создать маршрут.' if routes.empty?

    route = choose_route
    stations_in_route(route)

    puts "Выберите действие:\n1: Добавить станцию\n2: Удалить станцию"
    action = gets.chomp.to_i

    return puts 'Ошибка. Неверная команда.' unless [1, 2].include?(action)
    if action == 1
      station = choose_station_to_add(route)
      route.add_station(station)
      puts "Station #{station.title} added to the route."
    elsif action == 2
      station = choose_station_to_del(route)
      route.delete_station(station)
      puts "Station #{station.title} removed from the route."
    end
  end

  def appoint_route
    return puts 'Ошибка. Сначала нужно создать поезд и маршрут.' if trains.empty? || routes.empty?

    train = choose_train

    puts 'Выберите маршрут:'
    routes.each_with_index do |route, id|
      puts "#{id}: #{route} | #{route.stations.first.title}-#{route.stations.last.title}"
    end
    route = routes[gets.chomp.to_i]

    train.take_route(route)
    puts "Route #{route.stations.first.title}---#{route.stations.last.title} taken."
  end

  def add_vagon
    return puts 'Ошибка. Необходимо сначала создать поезд.' if trains.empty?

    train = choose_train

    if train.passenger?
      puts 'Укажите число пассажирских мест в вагоне:'
      vagon = PassengerVagon.new(seats: gets.chomp.to_i)
    elsif train.cargo?
      puts 'Укажите вместимость вагона:'
      vagon = CargoVagon.new(capacity: gets.chomp.to_i)
    end

    train.add_vagon(vagon)
    puts "Vagon #{vagon} added."
  end

  def remove_vagon
    return puts 'Ошибка. Необходимо сначала создать поезд.' if trains.empty?

    train = choose_train

    return puts 'Ошибка. У этого поезда нет вагонов.' if train.vagons.empty?

    vagon = choose_vagon(train)

    train.remove_vagon(vagon)
    puts "Vagon #{vagon} removed."
  end

  def move_train
    return puts 'Ошибка. Необходимо сначала создать поезд.' if trains.empty?

    train = choose_train

    return puts 'Ошибка. У этого поезда нет маршрута.' if train.route.nil?

    show_route(train)

    puts "Выберите действие:\n1: Вперед по маршруту\n2: Назад по маршруту"
    action = gets.chomp.to_i

    return puts 'Ошибка. Неверная команда.' unless [1, 2].include?(action)

    if action == 1
      return puts 'Ошибка. Конечная станция' if train.current_station == train.route.stations.last
      train.move_next_station
    elsif action == 2
      return puts 'Ошибка. Конечная станция' if train.current_station == train.route.stations.first
      train.move_back_station
    end

    puts "Train #{train.number} moved to station #{train.current_station.title}."
  end

  def show_stations
    puts 'Станции:'
    stations.each.with_index do |station, id|
      puts "#{id}: #{station} | title: #{station.title}"
    end
  end

  def show_trains_on_station
    puts 'Выберите станцию, на которой хотите посмотреть поезда:'
    stations.each.with_index do |station, id|
      puts "#{id}: #{station} | title: #{station.title}"
    end
    stations[gets.chomp.to_i].show_all_trains
  end

  def show_vagons
    train = choose_train

    train.each_vagon.with_index do |vagon, id|
      if train.passenger?
        print "#{id} | type: #{vagon.type} | free seats: #{vagon.free_seats} | "
        puts  "occupied: #{vagon.occupied_seats}"
      elsif train.cargo?
        print "#{id} | type: #{vagon.type} | empty space: #{vagon.empty_space} | "
        puts  "filled: #{vagon.filled_space}"
      end
    end
  end

  def fill_vagon
    return puts 'Ошибка. Необходимо сначала создать поезд.' if trains.empty?

    train = choose_train

    return puts 'Ошибка. У этого поезда нет вагонов.' if train.vagons.empty?

    vagon = choose_vagon(train)

    if train.passenger?
      puts vagon.occupy_seat ? 'Success! Passenger added.' : 'Error! All seats occupied!'
    elsif train.cargo?
      puts 'Укажите объем груза:'
      puts vagon.add_freight(gets.chomp.to_i) ? 'Success. Freight addded.' : 'Error. No space.'
    end
  end

  def run
    commands = %i[exit_programm show_commands create_station create_train create_route
                  edit_route appoint_route add_vagon remove_vagon move_train show_stations
                  show_trains_on_station show_vagons fill_vagon]
    show_commands

    loop do
      puts 'Выберите действие, введя номер команды. Список команд: <2>.'
      id = gets.chomp.to_i

      (1..14).include?(id) ? send(commands[id - 1]) : wrong_command
    end
  end

  private

  def choose_train
    puts 'Выберите поезд:'
    trains.each_with_index do |train, id|
      puts "#{id}: #{train} | Number: #{train.number} | Vagons quantity: #{train.vagons.count}"
    end

    trains[gets.chomp.to_i]
  end

  def choose_vagon(train)
    puts 'Выберите вагон:'
    train.each_vagon.with_index do |vagon, id|
      puts "#{id}: #{vagon}"
    end

    train.vagons[gets.chomp.to_i]
  end

  def choose_route
    puts 'Выберите маршрут:'
    routes.each_with_index do |route, id|
      puts "#{id}: #{route} | #{route.stations.first.title}-#{route.stations.last.title}"
    end

    routes[gets.chomp.to_i]
  end

  def choose_station_to_add(route)
    puts 'Выберите станцию, чтобы добавить её:'
    curr_stations = stations.reject { |station| route.stations.include?(station) }
    curr_stations.each_with_index do |station, id|
      puts "#{id}: #{station} | #{station.title}"
    end

    curr_stations[gets.chomp.to_i]
  end

  def choose_station_to_del(route)
    puts 'Выберите станцию, чтобы удалить её:'
    route.stations.each_with_index do |station, id|
      puts "#{id}: #{station} | #{station.title}"
    end

    route.stations[gets.chomp.to_i]
  end

  def stations_in_route(route)
    puts 'Станции, входящие в маршрут:'
    route.stations.each_with_index do |station, id|
      puts "#{id}: #{station} | #{station.title}"
    end
  end

  def show_route(train)
    puts "Поезд сейчас на станции #{train.current_station.title}."
    puts 'Маршрут поезда:'
    train.route.stations.each_with_index do |station, id|
      puts "#{id}: #{station.title}"
    end
  end
end
