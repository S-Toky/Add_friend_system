class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :Invitations
  has_many :pending_invitations, -> { where confirmed: false }, class_name: 'Invitation', foreign_key: 'friend_id'

  def friends 
    friend_send_invitation = Invitation.where(user_id: id, confirmed: true).pluck(:friend_id)
    friend_have_invitation = Invitation.where(friend_id: id, confirmed: true).pluck(:user_id)
    ids = friend_send_invitation + friend_have_invitation
    User.where(id: ids)
  end
  
  def friends_with?(user)
    Invitation.confirmed_record?(id, user.id)
  end
  
  def send_invitation
    invitations.create(friend_id: user.id)
  end

  def username
    return self.email.split('@')[0].capitalize
  end
  
end
