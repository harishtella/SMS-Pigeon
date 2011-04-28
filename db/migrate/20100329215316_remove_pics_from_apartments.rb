# ************************************************************
# written by: Harish Tella (ht@harishtella.info)
# [Copyright (C) 2010 Harish Tella, All rights reserved.]
# see included document, "license.txt", for more information.
# ************************************************************

class RemovePicsFromApartments < ActiveRecord::Migration
  def self.up
    remove_column :apartments, :pics
  end

  def self.down
    add_column :apartments, :pics, :text
  end
end
