module ResourceController
  module Helpers
    module Searchlogic
    
      def self.included(base)
        base.class_eval do
          alias_method_chain :end_of_association_chain, :searchlogic
        end
      end
    
      protected
    
      def end_of_association_chain_with_searchlogic
        end_of_association_chain_without_searchlogic.searchlogic(params[:search])
      end
    
    end
  end
end