module ResourceController
  module Helpers
    module Views
      
      protected

      # True if the named partial is found without falling back to the scaffold_root.
      def has_own_partial?(name)
        view_paths.find_template("_#{name}", default_template_format) != nil
      rescue ActionView::MissingTemplate
        return false
      end

      # Returns the options hash passed to the resource_controller declaration.
      def resource_controller_options
        self.class.resource_controller_options
      end
    
    end
  end
end