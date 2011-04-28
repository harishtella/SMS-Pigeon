class List < ActiveRecord::Base
  has_and_belongs_to_many :subscribers, :class_name => "User", 
  :join_table => "lists_users", :uniq => true
  has_many :messages, :class_name => "ListMessage",
  :dependent => :destroy
  has_one :keyword, :class_name => "Keyword", :as => :owner,
  :dependent => :destroy

  validates_presence_of :name
  validates_presence_of :description

  accepts_nested_attributes_for :keyword, :allow_destroy => true 
end

