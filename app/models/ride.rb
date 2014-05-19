class Ride
  include Mongoid::Document
  field :name, type: String
  field :difficulty, type: String
  field :start_time_hour, type: Integer
  field :start_time_min, type: Integer
  field :start_time_am, type: String
  field :frequency, type: String
  field :meeting_points, type: String

  field :ride_admin, type: String
  field :ride_creator, type: String

  has_and_belongs_to_many :users
  belongs_to :route

  validates_presence_of :name, :difficulty, :start_time_hour, :start_time_min, :start_time_am, :frequency

end
