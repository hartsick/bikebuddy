class Route
  include Mongoid::Document
  field :name, type: String
  field :route_start, type: String
  field :route_end, type: String
  # field :qualities, type: String

  validates_presence_of :name, :route_start, :route_end

  has_many :rides
  belongs_to :user
end
