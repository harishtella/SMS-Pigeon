# ************************************************************
# written by: Harish Tella (ht@harishtella.info)
# [Copyright (C) 2010 Harish Tella, All rights reserved.]
# see included document, "license.txt", for more information.
# ************************************************************

class AddNameToUser < ActiveRecord::Migration
  def self.up
    add_column :users , :name, :string
  end

  def self.down
    remove_column :users, :name
  end
end
