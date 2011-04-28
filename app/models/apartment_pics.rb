class ApartmentPics < ActiveRecord::Base
  belongs_to :apartment

  #validates_format_of :url, :with => URI::regexp(%w(http https))

  def to_s 
    "#{self.url}"
  end

  def full_url
    if self.url[0..6].eql? "http://"
      "#{self.url}"
    else 
      "http://" + "#{self.url}"  
    end
  end
end
