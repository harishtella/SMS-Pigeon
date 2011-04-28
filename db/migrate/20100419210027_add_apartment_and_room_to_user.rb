# ************************************************************
# written by: Harish Tella (ht@harishtella.info)
# [Copyright (C) 2010 Harish Tella, All rights reserved.]
# see included document, "license.txt", for more information.
# ************************************************************

class AddApartmentAndRoomToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :apartment_id, :integer
    add_column :users, :room, :string
  end

  def self.down
    remove_column :users, :apartment_id
    remove_column :users, :room
  end
end
