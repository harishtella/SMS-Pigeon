# ************************************************************
# written by: Harish Tella (ht@harishtella.info)
# [Copyright (C) 2010 Harish Tella, All rights reserved.]
# see included document, "license.txt", for more information.
# ************************************************************

class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :number
      t.integer :last_apt_queried_id

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
