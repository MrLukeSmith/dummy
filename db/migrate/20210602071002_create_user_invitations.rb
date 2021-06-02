class CreateUserInvitations < ActiveRecord::Migration[6.0]
  def change
    create_table :user_invitations do |t|
      t.string :email

      t.timestamps
    end
  end
end
