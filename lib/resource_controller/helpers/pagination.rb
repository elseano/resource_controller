module ResourceController
  module Helpers
    module Pagination
      
      protected
      
      def collection
        end_of_association_chain.paginate(:page => params[:page], :per_page => self.class.resource_controller_options[:per_page] || params[:per_page] || 20)
      end
      
    end
  end
end