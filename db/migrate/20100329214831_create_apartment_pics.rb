# ************************************************************
# written by: Harish Tella (ht@harishtella.info)
# [Copyright (C) 2010 Harish Tella, All rights reserved.]
# see included document, "license.txt", for more information.
# ************************************************************

class CreateApartmentPics < ActiveRecord::Migration
  def self.up
    create_table :apartment_pics do |t|
      t.string :url
      t.timestamps
    end
  end

  def self.down
    drop_table :apartment_pics
  end
end
