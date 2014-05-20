class User
  include Mongoid::Document
  include Mongoid::Paperclip

  # Include this after_commit so that paperclip doesn't freak out
   def self.after_commit(*args, &block)
     args.each do |arg|
     case arg[:on]
       when :destroy
         after_destroy &block
       end
     end
   end

  has_mongoid_attached_file :avatar,
   :styles => {
      :thumb => "100x100#",   # Centrally cropped
      :small  => "150x150>"}  # Only squish if it's larger than this

  field :username, type: String
  field :name, type: String
  field :email, type: String
  field :time_zone, type: String
  field :password_digest, type: String

  field :phone, type: String

  has_many :routes
  has_and_belongs_to_many :rides

  validates_presence_of :username, :name, :email, :password_digest, :phone

  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

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
