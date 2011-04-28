# ************************************************************
# written by: Harish Tella (ht@harishtella.info)
# [Copyright (C) 2010 Harish Tella, All rights reserved.]
# see included document, "license.txt", for more information.
# ************************************************************

class CreateApartmentStatuses < ActiveRecord::Migration
  def self.up
    create_table :apartment_statuses do |t|
      t.text :status

      t.timestamps
    end
  end

  def self.down
    drop_table :apartment_statuses
  end
end
