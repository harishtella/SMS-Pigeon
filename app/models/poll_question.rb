class PollQuestion < ActiveRecord::Base
  has_many :choices, :class_name => "PollChoice"
  belongs_to :poll

  accepts_nested_attributes_for :choices, :allow_destroy => true
end
