# ************************************************************
# written by: Harish Tella (ht@harishtella.info)
# [Copyright (C) 2010 Harish Tella, All rights reserved.]
# see included document, "license.txt", for more information.
# ************************************************************

class CreateSms < ActiveRecord::Migration
  def self.up
    create_table :sms do |t|
      t.string :text
      t.boolean :incoming 
      t.timestamps
    end
  end

  def self.down
    drop_table :sms
  end
end
