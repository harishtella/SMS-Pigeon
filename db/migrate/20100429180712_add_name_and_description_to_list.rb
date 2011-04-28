# ************************************************************
# written by: Harish Tella (ht@harishtella.info)
# [Copyright (C) 2010 Harish Tella, All rights reserved.]
# see included document, "license.txt", for more information.
# ************************************************************

class AddNameAndDescriptionToList < ActiveRecord::Migration
  def self.up
    add_column :lists, :name, :string
    add_column :lists, :description, :string
  end

  def self.down
    remove_column :lists, :name
    remove_column :lists, :description 
  end
end
