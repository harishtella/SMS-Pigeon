class ApartmentQuery < ActiveRecord::Base
  belongs_to :apartment
  belongs_to :user

  def datetime_string 
    "#{self.created_at.strftime('%b %e @ %l:%M %p')}"
  end
end
