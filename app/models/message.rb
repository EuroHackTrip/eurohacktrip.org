class Message
  include ActiveAttr::Model
  
  attribute :name
  attribute :message #robot tricker
  attribute :email
  attribute :subject
  attribute :body
  
  validates_presence_of :name
  # validates_format_of :email, :with => /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i
  validates_length_of :body, :maximum => 500

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end
end