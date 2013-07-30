#encoding: utf-8
class Admin::SchoolsController < ApplicationController
  before_filter :prevent_non_admin

  def new
    @school = School.new
    @school.contactinfo ||= Contactinfo.new
    @school.contactinfo.city ||= City.new
    @schools = School.all
  end

  def create
    begin
      @school = School.new(params[:school])
      if @school.save
        render :json => @school.to_json(:include => {:contactinfo => {:include => :city}, :schooltype => {}, :schoolboard => {} } )
      else
        render :json => {:message => @school.errors.full_messages}, :status => :unprocessable_entity
      end
    rescue => e
      render :json => {:message => e.message}, :status => :unprocessable_entity
    end
  end

  def destroy
    begin
      @school = School.find(params[:id])
      if @school
        @school.destroy
        render :json => {:message => "L'école a été supprimée avec succès"}, :status => :ok
      else
        render :json => {:message => "L'école'n'a pas été trouvée"}, :status => :unprocessable_entity
      end
    rescue
      render :json => {:message => "L'école est liée à d'autres objets dans la base de données (utilisateurs, inscriptions, ...). Veuillez les supprimer en premier."}, :status => :unprocessable_entity
    end
  end

  def update
    begin
      @school = School.find(params[:id])
      if @school
        if @school.update_attributes(params[:school])
          render :json => @school.to_json(:include => {:contactinfo => {:include => :city}, :schooltype => {}, :schoolboard => {} } )
        else
          render :json =>{:message => "L'école' n'a pu être mise à jour"}, :status => :unprocessable_entity
        end
      else
        render :json => {:message =>  "L'école'n'a pas été trouvée"}, :status => :unprocessable_entity
      end
    rescue
      render :json => {:message => "Erreur lors de la mise à jour de l'école'"}, :status => :unprocessable_entity
    end
  end

  def show
    @school = School.find(params[:id])
    render :json => @school.to_json(:include => {:contactinfo => {:include => :city}, :schooltype => {}, :schoolboard => {} } ), :status => :ok
  end

end
