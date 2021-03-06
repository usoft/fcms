#encoding: utf-8

##
# Controller to manipulate rooms in the application
class Admin::RoomsController < ApplicationController
  before_filter :prevent_non_admin

  ##
  # Display the page to see all the rooms in the application
  def new
    @room = Room.new
    @rooms = Room.all
  end

  ##
  # Create a room that will be used by FCMS
  def create
    begin
      @room = Room.new(params[:room])

      if @room.save
        render :json => @room
      else
        render :json => {:message => @room.errors.full_messages}, :status => :unprocessable_entity
      end
    rescue
      render :json => {:message => @room.errors.full_messages}, :status => :unprocessable_entity
    end
  end

  ##
  # Delete the room
  def destroy
    begin
      @room = Room.find(params[:id])
      if @room
        @room.destroy
        render :json => {:message => "La salle a été supprimée avec succès"}, :status => :ok
      else
        render :json => {:message =>  "La salle n'a pas été trouvée"}, :status => :unprocessable_entity
      end
    rescue
      render :json => {:message => "La pièce est liée à d'autres objets dans la base de données. Veuillez les supprimer en premier."}, :status => :unprocessable_entity
    end
  end

  ##
  # Update information about the room
  def update
    begin
      @room = Room.find(params[:id])
      if @room
        if @room.update_attributes(params[:room])
          render :json => @room
        else
          render :json => {:message => "La salle n'a pu être mise à jour"}, :status => :unprocessable_entity
        end
      else
        render :json => {:message => "La salle n'a pas été trouvée"}, :status => :unprocessable_entity
      end
    rescue
      render :json => {:message => "Erreur lors de la mise à jour de la salle"}, :status => :unprocessable_entity
    end
  end

  ##
  # JSON request to return basic information of a room
  def show
    @room = Room.find(params[:id])
    render :json => @room
  end

end
