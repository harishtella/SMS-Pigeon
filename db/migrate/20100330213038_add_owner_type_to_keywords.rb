# ************************************************************
# written by: Harish Tella (ht@harishtella.info)
# [Copyright (C) 2010 Harish Tella, All rights reserved.]
# see included document, "license.txt", for more information.
# ************************************************************

class AddOwnerTypeToKeywords < ActiveRecord::Migration
  def self.up
    add_column :keywords, :owner_type, :string
  end

  def self.down
    remove_column :keywords, :owner_type
  end
end
