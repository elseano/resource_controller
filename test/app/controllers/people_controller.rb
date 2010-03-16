class PeopleController < ApplicationController
  resource_controller :scaffold_root => "app/views/scaffold"
  
  create.before :name_person
  model_name    :account
  
  private
    def name_person
      @person.name = "Bob Loblaw"
    end
end
