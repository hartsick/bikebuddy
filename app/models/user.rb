class User
  include Mongoid::Document
  # include Mongoid::Paperclip
  field :username, type: String
  field :name, type: String
  field :email, type: String
  field :time_zone, type: String
  field :password_digest, type: String

  field :phone, type: String
  # has_mongoid_attached_file :avatar
  # validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  has_many :routes
  has_and_belongs_to_many :rides

  validates_presence_of :username, :name, :email, :password_digest, :phone

  def password
  	@password
  end

  # def password_redux
  # 	@password_redux
  # 	if @password_redux
	 #  	unless @password == @password_redux
	 #  		flash[:error] = "Your passwords don't match!"
	 #  		false
	 #  	else
	 #  		true
	 #  	end
	 #  end
  # end

  def password=(new_password)
    @password = new_password
		self.password_digest = BCrypt::Password.create(new_password)
  end

  def authenticate(test_password)
    if BCrypt::Password.new(self.password_digest) == test_password
      self
    else
      false
    end
  end
end
