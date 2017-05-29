module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def instances
      @instances
    end
    
    protected

    def instance_inc
      @instances.nil? ? @instances = 1 : @instances += 1
    end
  end

  module InstanceMethods

    protected

    def register_instance
      self.class.send :instance_inc
    end
  end
end