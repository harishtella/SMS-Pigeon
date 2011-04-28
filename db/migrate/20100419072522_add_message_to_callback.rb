# ************************************************************
# written by: Harish Tella (ht@harishtella.info)
# [Copyright (C) 2010 Harish Tella, All rights reserved.]
# see included document, "license.txt", for more information.
# ************************************************************

class AddMessageToCallback < ActiveRecord::Migration
  def self.up
    add_column :apartment_callbacks, :message, :string
    remove_column :apartment_callbacks, :name
  end

  def self.down
    add_column :apartment_callbacks, :name, :string
    remove_column :apartment_callbacks, :message
  end
end
