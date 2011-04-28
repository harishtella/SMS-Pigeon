# ************************************************************
# written by: Harish Tella (ht@harishtella.info)
# [Copyright (C) 2010 Harish Tella, All rights reserved.]
# see included document, "license.txt", for more information.
# ************************************************************

class CreatePolls < ActiveRecord::Migration
  def self.up
    create_table :polls do |t|
      t.string :keyword
      t.string :title

      t.timestamps
    end
  end

  def self.down
    drop_table :polls
  end
end
