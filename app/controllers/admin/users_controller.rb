#encoding: utf-8

##
# Admin controller to edit or delete users registered to web application
class Admin::UsersController < ApplicationController
  before_filter :prevent_non_admin

  ##
  # Handle JSON request for ajax dataTables
  def index
    render json: UsersDatatable.new(view_context)
  end

  ##
  # Show the list of all users and a form to edit them
  def new
    @users  = User.all
    @user = User.new
    @user.contactinfo ||= Contactinfo.new
    @user.contactinfo.city ||= City.new
  end

  ##
  # Update specific information about the user (not permitting complete editing of user)
  def update
    begin
      @user = User.find(params[:id])

      if @user.update_attributes(params[:user])
        render json: @user, status: :ok
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    rescue
      render :json => {:message => "Erreur lors de la mise à jour de l'utilisateur"}, :status => :unprocessable_entity
    end
  end

  ##
  # Destroy all traces of a user. Delete roles, registrations, performances, ...
  def destroy
    begin
      @user = User.find(params[:id])

      # Manually delete everything since we weren't aware of cascade delete rails models
      @user.roles.each do |role|
        @user.roles.delete(role)
      end

      @user.registrations.each do |registration|
        RegistrationsUser.find_all_by_registration_id(registration.id).each do |regUser|
          RegistrationsUser.delete(regUser)
        end

        Performance.find_all_by_registration_id(registration.id).each do |performance|
          Performance.delete(performance)
        end

        Payment.find_all_by_registration_id(registration.id).each do |payment|
          Payment.delete(payment)
        end

        Registration.delete(registration)
      end

      Registration.find_all_by_user_owner_id(@user.id).each do |registration|
        RegistrationsUser.find_all_by_registration_id(registration.id).each do |regUser|
          RegistrationsUser.delete(regUser)
        end

        Performance.find_all_by_registration_id(registration.id).each do |performance|
          Performance.delete(performance)
        end

        Payment.find_all_by_registration_id(registration.id).each do |payment|
          Payment.delete(payment)
        end

        Registration.delete(registration)
      end

      Registration.find_all_by_user_teacher_id(@user.id).each do |registration|
        RegistrationsUser.find_all_by_registration_id(registration.id).each do |regUser|
          RegistrationsUser.delete(regUser)
        end

        Performance.find_all_by_registration_id(registration.id).each do |performance|
          Performance.delete(performance)
        end

        Payment.find_all_by_registration_id(registration.id).each do |payment|
          Payment.delete(payment)
        end

        Registration.delete(registration)
      end

      @user.delete
      render :json => {:message => "L'utilisateur a bien été supprimé!"}, :status => :unprocessable_entity
    rescue => e
      render :json => {:message => e.message }, :status => :unprocessable_entity
    end
  end

  ##
  # JSON request to return basic information about a user
  def show
    @user = User.find(params[:id])
    render :json => @user.to_json(:include => {:contactinfo => {:include => :city}})
  end

  ##
  # Create excel with all information about users in the application with roles, emails, infos, ...
  def ProduceExcel
    require 'axlsx'

    headers = ["Nom", "Prénom", "Âge", "Rôle(s)", "Nombre d'inscriptions", "Courriel", "#Tel", "Rue", "Ville", "Code postal"]

    Axlsx::Package.new do |p|
      p.workbook.styles do |s|

        string_cell = s.add_style :sz => 12, :alignment => {  :wrap_text => true}

        p.workbook.add_worksheet(:name => "USERS") do |sheet|
          sheet.add_row headers
          User.all.each do |u|

            roles = u.roles.map {|r| r.name}.join("\r\n")

            if c = u.contactinfo
              tel = c.telephone
              rue = c.address
              c.city ? ville = c.city.name : ville = ""
              post = c.postal_code
            else
              tel   =  rue   =  ville =  post  = ""
            end
            regcount = u.registrations.where(edition_id: Setting.find_by_key('current_edition_id')).size
            sheet.add_row [u.last_name, u.first_name, u.age , roles, regcount, u.email, tel,rue, ville, post], :style => string_cell

          end

          sheet.to_xml_string
        end
      end

      p.use_shared_strings = true     # THAT'S FOR LINE RETURNS FORMATTING...
      # This writes the file locally. I don't think we need it on the server
      #p.serialize("FCMS-Utilisateurs-#{Edition.find(Setting.find_by_key('current_edition_id').value).year}.xls")
      send_data p.to_stream.read, :filename => "FCMS-Utilisateurs-#{Edition.find(Setting.find_by_key('current_edition_id').value).year}.xlsx", :type => "application/vnd.openxmlformates-officedocument.spreadsheetml.sheet"
    end
  end
end
