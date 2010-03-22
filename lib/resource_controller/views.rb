
module ResourceController
  module Views
    
    private
    
    # Use dynamic scaffold fallback if a template can't be found in the view paths.
    def default_template(action_name = self.action_name)
      view_paths.find_template(default_template_name(action_name), default_template_format)
    rescue ActionView::MissingTemplate
      raise if controller.resource_controller_options[:scaffold_root].blank?
      
      scaffold_paths = view_paths.class.new
      scaffold_paths.unshift(controller.resource_controller_options[:scaffold_root])
      scaffold_paths.find_template(action_name, default_template_format)
    end
  end
end