# ************************************************************
# written by: Harish Tella (ht@harishtella.info)
# [Copyright (C) 2010 Harish Tella, All rights reserved.]
# see included document, "license.txt", for more information.
# ************************************************************

class AddAptIdToApartmentPic < ActiveRecord::Migration
  def self.up
    add_column :apartment_pics, :apartment_id, :integer
  end

  def self.down
    remove_column :apartment_pics, :apartment_id
  end
end
