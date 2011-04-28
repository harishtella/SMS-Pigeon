class Apartment < ActiveRecord::Base
  has_many :statuses, :class_name => "ApartmentStatus",
  :dependent => :destroy
  has_many :pics, :class_name => "ApartmentPics",
  :dependent => :destroy
  has_many :callbacks, :class_name => "ApartmentCallback",
  :dependent => :destroy
  has_one :keyword, :class_name => "Keyword", :as => :owner, 
  :dependent => :destroy
  has_many :queries, :class_name => "ApartmentQuery",
  :dependent => :destroy

  accepts_nested_attributes_for :statuses, :allow_destroy => true 
  accepts_nested_attributes_for :pics, :allow_destroy => true 
  accepts_nested_attributes_for :keyword, :allow_destroy => true 

  validates_presence_of :address

  def find_int_peeps(start_date, end_date)
    q = self.queries.find(:all, 
    :conditions => { :created_at_lte => end_date,
    :created_at_gte => start_date })

    q.collect!{|x| x.user}
    q.uniq!
    return q
  end

  def queries_ordered
    self.queries.find(:all, 
    :order => "created_at DESC", :limit => 15)
  end

  def callbacks_outstanding_ordered
    self.callbacks.find(:all, :conditions => {:completed => false}, :order => "created_at ASC")
  end

  def callbacks_all_ordered
    self.callbacks.find(:all, :order => "created_at DESC")
  end

  def current_status
    self.statuses.first(:order => "created_at DESC")
  end
  
  def past_statuses
    self.statuses.find(:all, :order => "created_at DESC", 
    :offset => 1, :limit => 15) 
  end

end
