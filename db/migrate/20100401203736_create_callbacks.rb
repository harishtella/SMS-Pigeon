# ************************************************************
# written by: Harish Tella (ht@harishtella.info)
# [Copyright (C) 2010 Harish Tella, All rights reserved.]
# see included document, "license.txt", for more information.
# ************************************************************

class CreateCallbacks < ActiveRecord::Migration
  def self.up
    create_table :callbacks do |t|
      t.string :name
      t.datetime :apt_time
      t.integer :apartment_id
      t.boolean :completed, :default => false
      t.timestamps
    end
  end

  def self.down
    drop_table :callbacks
  end
end
