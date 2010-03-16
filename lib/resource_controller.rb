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
    
    # Adds resource_controller functionality to a view. Options can be passed into this method to modify the view and action behaviours.
    # 
    # Options Include:
    #
    # :searchlogic => Pull searchlogic options from the @search variable. Also provides @search to views.
    # :scaffold_root => The path which contains the default views to use if they're not present in the controllers view path.
    # :pagination => Use pagination. Pulls the per_page option from either the resource_controller declaration, or params (defaults to 20 otherwise).
    # :per_page => How many items to display per page. Activates pagination if not explicitly activated.
    #
    # Notes:
    # All options given to resource_controller are available to the views and controllers through the method resource_controller_options which is a Hash.
    # This can be useful to define things such as headings, etc at the view level.
    def resource_controller(*args)
      cattr_accessor :resource_controller_options
      self.resource_controller_options = args.detect { |arg| arg.is_a?(Hash) } || Hash.new
      
      include ResourceController::Controller
      include ResourceController::Helpers::Pagination if resource_controller_options[:per_page] || resource_controller_options[:pagination]
      include ResourceController::Helpers::Searchlogic if resource_controller_options[:searchlogic] == true
      
      if args.include?(:singleton)
        include ResourceController::Helpers::SingletonCustomizations
      end
    end  
  end
end

require File.dirname(__FILE__)+'/../rails/init.rb' unless ActionController::Base.include?(Urligence)
