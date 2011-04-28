# ************************************************************
# written by: Harish Tella (ht@harishtella.info)
# [Copyright (C) 2010 Harish Tella, All rights reserved.]
# see included document, "license.txt", for more information.
# ************************************************************

class CreateSmsUsers < ActiveRecord::Migration
  def self.up
    create_table :sms_users, :id => false do |t|
      t.integer :sms_id
      t.integer :user_id
    end
  end

  def self.down
    drop_table :sms_users
  end
end
