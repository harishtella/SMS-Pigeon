class ApartmentStatus < ActiveRecord::Base
  belongs_to :apartment
  validates_presence_of :message

  def to_s 
    "#{self.message}"
  end

  def datetime_string 
    "#{self.created_at.strftime('%b %e @ %l:%M %p')}"
  end

  def message_html 
    "#{self.message}".gsub("\n", "<br/>") 
  end
end
