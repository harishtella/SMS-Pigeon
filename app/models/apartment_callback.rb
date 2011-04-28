class ApartmentCallback < ActiveRecord::Base
  belongs_to :apartment
  belongs_to :user

  def datetime_string 
    "#{self.created_at.strftime('%b %e @ %l:%M %p')}"
  end

  def self.outstanding 
    self.find(:all, :conditions => {:completed => false}, 
    :order => "created_at ASC") 
  end
end
