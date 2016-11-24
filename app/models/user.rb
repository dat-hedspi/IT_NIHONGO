class User < ApplicationRecord
  ratyrate_rater
  has_many :reviews, dependent: :destroy
  has_many :comments, dependent: :destroy

  mount_uploader :avatar, AvatarUploader

  devise :database_authenticatable, :registerable,
    :rememberable, :validatable, :recoverable,
    :omniauthable, :omniauth_providers => [:facebook]
  attr_accessor :login

  def is_user? current_user
    self == current_user
  end

  class << self
    def from_omniauth auth
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.email = auth.info.email
        user.password = Settings.default_password
        user.username = auth.info.name
      end
    end

    def new_with_session params, session
      super.tap do |user|
        if data = session["devise.facebook_data"] &&
          session["devise.facebook_data"]["extra"]["raw_info"]
          user.email = data["email"] if user.email.blank?
        end
      end
    end
  end
end
