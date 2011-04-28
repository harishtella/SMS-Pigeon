# ************************************************************
# written by: Harish Tella (ht@harishtella.info)
# [Copyright (C) 2010 Harish Tella, All rights reserved.]
# see included document, "license.txt", for more information.
# ************************************************************

class AddPcbDisabledToApartments < ActiveRecord::Migration
  def self.up
    add_column :apartments, :pcb_disabled, :boolean,
    :default => false
  end

  def self.down
    remove_column :apartments, :pcb_disabled
  end
end
