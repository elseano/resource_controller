module ResourceController
  module Partials
    
    def self.included(base)
      base.module_eval do
        alias_method_chain :_pick_partial_template, :scaffold
      end
    end
    
    def _pick_partial_template_with_scaffold(partial_path) #:nodoc:
      _pick_partial_template_without_scaffold(partial_path)
    rescue ActionView::MissingTemplate
      Rails.logger.debug("[DynamicScaffold] Using scaffold partial #{partial_path}")
      
      raise "Attempting to call a resource_controller_views partial from a controller which isn't resource_controller enabled." if !controller.respond_to?(:resource_controller_options)
      raise if controller.nil? || controller.resource_controller_options[:scaffold_root].blank?
      
      scaffold_paths = view_paths.class.new
      scaffold_paths.unshift(controller.resource_controller_options[:scaffold_root] || "app/views/scaffold")
      scaffold_paths.find_template("_#{partial_path}", self.template_format)
    end
  end
end

ActionView::Partials.send(:include, ResourceController::Partials)