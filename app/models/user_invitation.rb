class UserInvitation < ApplicationRecord

  scope :email, -> (email) { where(email: email) }

end
