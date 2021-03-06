module Acessors
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def attr_accessor_with_history(*args)
      args.each do |arg|
        var_name = "@#{arg}".to_sym

        define_method(arg) { instance_variable_get(var_name) }

        define_method("#{arg}=".to_sym) do |value|
          instance_variable_set(var_name, value)
          @var_values ||= Hash.new { |h, k| h[k] = [] }
          @var_values[arg] << value
        end

        define_method("#{arg}_history") { @var_values[arg] }
      end
    end

    def strong_attr_acessor(attr_name, class_type)
      var_name = "@#{attr_name}".to_sym

      define_method(attr_name.to_sym) { instance_variable_get(var_name) }
      define_method("#{name}=") do |value|
        raise 'Error' unless value.instance_of?(class_type)
        instance_variable_set(var_name, value)
      end
    end
  end
end
