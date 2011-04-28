class User < ActiveRecord::Base
  belongs_to :last_apt_queried, :class_name => "Apartment" 
  has_many :apt_queries, :class_name => "ApartmentQuery",
  :dependent => :destroy
  has_many :poll_votes, :class_name => "PollVote",
  :dependent => :destroy
  has_many :callbacks, :class_name => "ApartmentCallback",
  :dependent => :destroy
  has_and_belongs_to_many :lists, :join_table => "lists_users" 

  belongs_to :apartment

  validates_presence_of :name
  validate :number_format
  validates_uniqueness_of :number

  before_validation :add_default_name

  def add_default_name
    if self.name.eql? "" or self.name.nil?
      self.name = "--"
    end
  end  


  def number_format
    number_regex = /\+1(\d){10,10}$/
    errors.add(:number, "must be 10 numbers") unless
    number_regex.match(number)
  end

  def number_string
    if number[0..1].eql? "+1" 
      #number without country code
      num = self.number[2..number.size-1]
      if num.size.eql? 10
        return "#{num[0..2]}-#{num[3..5]}-#{num[6..9]}"
      else
        return "#{num}"
      end
    else 
      return "#{self.number}"
    end
  end

  def num1 
    num = self.number[2..number.size-1]
    return "#{num[0..2]}"
  end

  def num2 
    num = self.number[2..number.size-1]
    return "#{num[3..5]}"
  end

  def num3 
    num = self.number[2..number.size-1]
    return "#{num[6..9]}"
  end

  def self.for(number)
    if User.exists?(:number => number) 
      return User.find_by_number(number)
    else
      new_user = User.new()
      new_user.number = number 
      new_user.save()
      return new_user
    end
  end

  def name_string 
    "#{self.name}"
  end

  def poll_votes_ordered
    self.poll_votes.find(:all, :order => "created_at DESC")
  end
  def apt_queries_ordered
    self.apt_queries.find(:all, :order => "created_at DESC", :limit => 50)
  end
  def callbacks_ordered
    self.callbacks.find(:all, :order => "created_at DESC", :limit => 50)
  end

end
