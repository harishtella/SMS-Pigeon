class Poll < ActiveRecord::Base
  has_many :questions, :class_name => "PollQuestion"
  has_one :keyword, :class_name => "Keyword", :as => :owner

  accepts_nested_attributes_for :questions, :allow_destroy => true 
  accepts_nested_attributes_for :keyword, :allow_destroy => true 
end
