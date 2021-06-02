class User < ApplicationRecord
  include Clearance::User

  validates :name, presence: true

  validates :email, inclusion: { in: UserInvitation.pluck("email"), message: "That email address isn't approved." }, on: :create
  after_create :purge_invitation

private

  def purge_invitation
    UserInvitation.email(self.email).destroy_all
  end

end
