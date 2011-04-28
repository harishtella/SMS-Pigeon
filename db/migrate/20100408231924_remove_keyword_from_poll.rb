# ************************************************************
# written by: Harish Tella (ht@harishtella.info)
# [Copyright (C) 2010 Harish Tella, All rights reserved.]
# see included document, "license.txt", for more information.
# ************************************************************

class RemoveKeywordFromPoll < ActiveRecord::Migration
  def self.up
    remove_column :polls, :keyword
  end

  def self.down
    add_column :polls, :keyword, :string
  end
end
