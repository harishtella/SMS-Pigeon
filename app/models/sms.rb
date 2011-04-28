class SMS < ActiveRecord::Base

  has_and_belongs_to_many :users, :class_name => "User", 
  :join_table => "sms_users", :uniq => true


  # sometimes kannel gives rails 
  #an empty sms when it gets overloaded

  #validates_presence_of :text
  validates_presence_of :users
  validates_inclusion_of :incoming, :in => [true, false]

  def datetime_string 
    "#{self.created_at.strftime('%b %e @ %l:%M %p')}"
  end



end
