class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,:omniauthable, :omniauth_providers => [:facebook]
  has_many :reviews
  attr_accessor :login

  def has_rated_this(show_id)
    count = Review.where(user_id: self.id).where(movie_id: show_id).where('rating IS NOT NULL').count
    if count > 0
      return true
    else
      return false
    end
  end

  def has_recommended_this(show_id)
    count = Review.where(user_id: self.id).where(movie_id: show_id).where(recommend: true).count
    if count > 0
      return true
    else
      return false
    end
  end

  def has_reviewed_this(show_id)
    count = Review.where(user_id: self.id).where(movie_id: show_id).where('review is not null').count
    if count > 0
      return true
    else
      return false
    end
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name   # assuming the user model has a name
      if !auth.info.birthday.nil?
        user.birthday = Date.parse(auth.extra.raw_info.birthday)
      end
      # If you are using confirmable and the provider(s) you use validate emails, 
      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
    end
  end

end