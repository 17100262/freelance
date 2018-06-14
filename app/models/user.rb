class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :lockable,
         :recoverable, :rememberable, :trackable, :validatable,:omniauthable, omniauth_providers: %i[facebook linkedin google_oauth2 twitter]
  
  validates :username, presence: true, uniqueness: true
  
  has_many :jobs_as_employer, class_name: "Job", dependent: :destroy
  
  has_many :reservations
  has_many :statements
  has_many :jobs_as_worker, :through => :reservations,source: :job
  has_many :notifications,dependent: :destroy,class_name: "Notif"
  has_many :chat_subscribers, as: :subscriber, class_name: 'ChatEngine::ChatSubscriber'
  has_many :chats, through: :chat_subscribers, class_name: 'ChatEngine::Chat'
  has_many :messages, as: :sender, class_name: 'ChatEngine::Message'
  
  
  
  def reservations_as_employer
    Reservation.where(job: self.jobs_as_employer)
  end
  
  def reservations_as_worker
    self.reservations.where(job: self.jobs_as_worker)
  end
  
  
  def make_admin
    self.update!(admin: true)
  end
  
  def is_admin?
    return self.admin
  end
  
  def self.admins
    return User.where(admin: true)
  end
  
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.linkedin_link = auth.info.urls.public_profile if auth.provider=="linkedin"
      user.name = auth.info.name   # assuming the user model has a name
      # user.image = auth.info.image # assuming the user model has an image
      # If you are using confirmable and the provider(s) you use validate emails, 
      # uncomment the line below to skip the confirmation emails.
      user.skip_confirmation!
    end
  end
  
  def fullname
    if self.admin
      return "Customer Support"
    else
      return (User.column_names.include? "name" and self.name.present?) ? self.name: self.email.split('@')[0]
    end
  end
  
  def check_reservations
    max = Variable.find_by_name("MAX_RESERVATIONS").value
    return self.reservations.where(status: "LIVE").count >= max
  end
  
  def check_reservations
    max = Variable.find_by_name("MAX_RESERVATIONS").value
    return self.reservations.where(status: "LIVE").count >= max
  end
  
  def check_jobs
    max = Variable.find_by_name("MAX_JOBS").value
    return self.jobs_as_employer.where(status: "LIVE").count >= max
  end
  
end
