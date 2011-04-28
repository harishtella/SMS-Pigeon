# ************************************************************
# written by: Harish Tella (ht@harishtella.info)
# [Copyright (C) 2010 Harish Tella, All rights reserved.]
# see included document, "license.txt", for more information.
# ************************************************************

class CreateLists < ActiveRecord::Migration
  def self.up
    create_table :lists do |t|
      t.timestamps
    end
  end

  def self.down
    drop_table :lists
  end
end
