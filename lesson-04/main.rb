require_relative 'route'
require_relative 'station'
require_relative 'train'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'vagon'
require_relative 'passenger_vagon'
require_relative 'cargo_vagon'
require_relative 'controller'
# require_relative 'test'

controller = Controller.new.run
