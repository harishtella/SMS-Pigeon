# ************************************************************
# written by: Harish Tella (ht@harishtella.info)
# [Copyright (C) 2010 Harish Tella, All rights reserved.]
# see included document, "license.txt", for more information.
# ************************************************************

class AddMessageToApartmentStatus < ActiveRecord::Migration
  def self.up
    rename_column :apartment_statuses, :status, :message
  end

  def self.down
    rename_column :apartment_statuses, :message, :status
  end
end
