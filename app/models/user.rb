class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :image, :admin
  attr_accessible :provider, :uid, :partner 

  has_many :events, :through => :joins
  has_many :joins

  has_many :uploaded_events, :class_name => 'Event', :foreign_key => 'uploader_id'


  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
  	image =  auth.info.image
  	user = User.where(:provider => auth.provider, :uid => auth.uid).first
  	unless user
    	user = User.create(name:auth.extra.raw_info.name,
    					 image:auth.info.image,
                         provider:auth.provider,
                         uid:auth.uid,
                         email:auth.info.email,
                         password:Devise.friendly_token[0,20]
                         )
  	end
  	user
  end
  # attr_accessible :title, :body
end
