module Validation
  def self.included(base)
    base.extend  ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    attr_reader :validations

    def validate(attribute, type, params = nil)
      @validations ||= []
      @validations << [type, attribute, params]
    end
  end

  module InstanceMethods
    def validate!
      self.class.validations.each do |v|
        checking_method = "check_#{v[0]}".to_sym
        attribute       = instance_variable_get("@#{v[1]}")
        params          = v[2]

        send(checking_method, attribute, params)
      end
    end

    def valid?
      validate!
      true
    rescue
      false
    end

    private

    def check_presence(var, _params)
      raise 'Presence error' if var.empty? || var.nil?
    end

    def check_format(var, pattern)
      raise 'Format error' unless pattern.match(var)
    end

    def check_type(var, obj_type)
      puts var.class
      raise 'Type error' unless var.instance_of?(obj_type)
    end
  end
end
