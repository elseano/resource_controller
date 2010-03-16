begin
  require_dependency 'application_controller'
rescue LoadError => e
  require_dependency 'application'
end

module ResourceController
  ACTIONS           = [:index, :show, :new_action, :create, :edit, :update, :destroy].freeze
  SINGLETON_ACTIONS = (ACTIONS - [:index]).freeze
  FAILABLE_ACTIONS  = ACTIONS - [:index, :new_action, :edit].freeze
  NAME_ACCESSORS    = [:model_name, :route_name, :object_name]  
  
  module ActionControllerExtension
    unloadable
    
    def resource_controller(*args)
      cattr_accessor :resource_controller_options
      self.resource_controller_options = args.detect { |arg| arg.is_a?(Hash) } || Hash.new
      
      include ResourceController::Controller
      include ResourceController::Helpers::Searchlogic if resource_controller_options[:searchlogic] == true
      
      if args.include?(:singleton)
        include ResourceController::Helpers::SingletonCustomizations
      end
    end  
  end
end

require File.dirname(__FILE__)+'/../rails/init.rb' unless ActionController::Base.include?(Urligence)
