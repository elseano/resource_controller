class PhotosController < ApplicationController
  resource_controller :scaffold_root => "app/views/scaffold"
  
  actions :all, :except => :update
  actions :all, :except => :update
  
  belongs_to :user
  create.flash { "#{@photo.title} was created!" }
  
  private
    def parent_model
      Account
    end
end
