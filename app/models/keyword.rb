class Keyword < ActiveRecord::Base
  belongs_to :owner, :polymorphic => true
  validates_uniqueness_of :value, :message => 
  "is already being used"
  validates_presence_of :value
  before_validation :lowcase

  def to_s 
    "#{self.value}"
  end

  def lowcase
    self.value = self.value.downcase
  end

end
