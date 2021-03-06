# TL;DR: YOU SHOULD DELETE THIS FILE
#
# This file is used by web_steps.rb, which you should also delete
#
# You have been warned
module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /^the sign in\s?page$/
      '/users/sign_in'

    when /^the home\s?page$/
      '/'

    when /^the sign up\s?page$/
      '/users/sign_up'

    when /^the forgotten password\s?page$/
      '/users/password/new'

    when /^the registration\s?page$/
      '/registration/new'

    when /^the profile\s?page$/
      edit_user_path(@u)

    when /^the user sign info\s?page$/
      edit_user_registration_path

    when /^the edition\s?page$/
      new_admin_edition_path

    when /^the admin registration\s?page$/
      new_admin_registration_path

    when /^the admin schoolboards\s?page$/
      new_admin_schoolboard_path

    when /^the admin composers\s?page$/
      new_admin_composer_path

    when /^the admin schools\s?page$/
      new_admin_school_path

    when /^the admin instruments\s?page$/
      new_admin_instrument_path

    when /^the admin rooms\s?page$/
      new_admin_room_path

    when /^the admin pieces\s?page$/
      new_admin_piece_path


    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      begin
        page_name =~ /^the (.*) page$/
        user_signed_in?  path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue NoMethodError, ArgumentError
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)
