class Role < ActiveRecord::Base

  # Association macros
  has_and_belongs_to_many :users # For authorizations

end
