# ************************************************************
# written by: Harish Tella (ht@harishtella.info)
# [Copyright (C) 2010 Harish Tella, All rights reserved.]
# see included document, "license.txt", for more information.
# ************************************************************

class CreateApartmentQueries < ActiveRecord::Migration
  def self.up
    create_table :apartment_queries do |t|
      t.integer :apartment_id
      t.integer :user_id
      t.timestamps
    end
  end

  def self.down
    drop_table :apartment_queries
  end
end
