class Controller
  attr_accessor :stations, :trains, :routes

  def initialize
    @stations = []
    @trains   = []
    @routes   = []
  end

  def wrong_command
    puts "Ошибка. Неверный номер команды."
  end

  def exit_programm
    puts "«Всего хорошего, и спасибо за рыбу!» — Дуглас Адамс"
    exit!
  end

  def show_commands
    puts "==== Основные команды ===="
    File.open('commands.txt').each.with_index(1) { |command, id| puts "#{id}: #{command}" }
  end

  def create_station
    puts "Введите название станции:"
    station_title = gets.chomp
    self.stations << Station.new(title: station_title)
  end

  def create_train
    puts "Введите номер поезда:"
    train_number = gets.chomp.to_i

    puts "Выберите тип поезда:"
    puts "1: Пассажирский"
    puts "2: Грузовой"
    train_type = gets.chomp.to_i

    if train_type == 1
      self.trains << PassengerTrain.new(number: train_number)
    elsif train_type == 2
      self.trains << CargoTrain.new(number: train_number)
    else
      puts "Ошибка. Неверный тип поезда."
    end
  end

  def create_route 
    return puts "Ошибка. Необходимо сначала создать как минимум 2 станции." if self.stations.size < 2

    puts "Выберите начальную станцию маршрута:"
    self.stations.each_with_index do |station, id| 
      puts "#{id}: #{station} | #{station.title}"
    end
    start = self.stations[gets.chomp.to_i]

    puts "Выберите конечную станцию маршрута:"
    curr_stations = self.stations.select { |station| station != start }
    curr_stations.each_with_index do |station, id|
      puts "#{id}: #{station} | #{station.title}"
    end
    finish = curr_stations[gets.chomp.to_i]

    self.routes << Route.new(start: start, finish: finish)
  end

  def edit_route
    return puts "Ошибка. Необходимо сначала создать маршрут." if self.routes.empty?

    puts "Выберите маршрут:"
    self.routes.each_with_index do |route, id| 
      puts "#{id}: #{route} | #{route.stations.first.title}-#{route.stations.last.title}"
    end
    route = self.routes[gets.chomp.to_i]

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
      curr_stations = self.stations.select { |station| !route.stations.include?(station) }
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

  def appoint_route
    return puts "Ошибка. Необходимо сначала создать поезд и маршрут." if self.trains.empty? || self.routes.empty?

    puts "Выберите поезд:"
    self.trains.each_with_index do |train, id| 
      puts "#{id}: #{train} | #{train.number}"
    end
    train = self.trains[gets.chomp.to_i]

    puts "Выберите маршрут:"
    self.routes.each_with_index do |route, id| 
      puts "#{id}: #{route} | #{route.stations.first.title}-#{route.stations.last.title}"
    end
    route = self.routes[gets.chomp.to_i]

    train.take_route(route)
  end

  def add_vagon
    return puts "Ошибка. Необходимо сначала создать поезд." if self.trains.empty?
      
    puts "Выберите поезд:"
    self.trains.each_with_index do |train, id| 
      puts "#{id}: #{train} | Train number: #{train.number}"
    end
    train = self.trains[gets.chomp.to_i]

    vagon = if train.passenger?
              PassengerVagon.new
            elsif train.cargo?
              CargoVagon.new
            end

    train.add_vagon(vagon)
  end

  def remove_vagon
    return puts "Ошибка. Необходимо сначала создать поезд." if self.trains.empty?

    puts "Выберите поезд:"
    self.trains.each_with_index do |train, id| 
      puts "#{id}: #{train} | #{train.number} | Vagons quantity: #{train.vagons.count}"
    end
    train = self.trains[gets.chomp.to_i]

    return puts "Ошибка. У этого поезда нет вагонов." if train.vagons.empty?

    puts "Выберите вагон:"
    train.vagons.each_with_index do |vagon, id| 
      puts "#{id}: #{vagon}"
    end
    vagon = train.vagons[gets.chomp.to_i]

    train.remove_vagon(vagon)
  end

  def move_train
    return puts "Ошибка. Необходимо сначала создать поезд." if self.trains.empty?

    puts "Выберите поезд:"
    self.trains.each_with_index do |train, id| 
      puts "#{id}: #{train} | #{train.number}"
    end
    train = self.trains[gets.chomp.to_i]

    return puts "Ошибка. У этого поезда нет маршрута." if train.route.nil?

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
        return puts "Ошибка. Поезд на конечной станции, движение вперед невозможно."
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

  def show_stations
    puts "Станции:"
    self.stations.each_with_index do |station, id| 
      puts "#{id}: #{station} | title: #{station.title}"
    end
  end

  def show_trains_on_station
    puts "Выберите станцию, на которой хотите посмотреть поезда:"
    self.stations.each_with_index do |station, id| 
      puts "#{id}: #{station} | title: #{station.title}"
    end
    self.stations[gets.chomp.to_i].show_all_trains
  end

  def run
    show_commands

    loop do
      puts "Выберите действие, введя номер команды. Список команд: <2>."
      action = gets.chomp.to_i

      case action
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
      else wrong_command
      end
    end
  end
end
