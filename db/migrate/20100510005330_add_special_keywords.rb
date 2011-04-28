# ************************************************************
# written by: Harish Tella (ht@harishtella.info)
# [Copyright (C) 2010 Harish Tella, All rights reserved.]
# see included document, "license.txt", for more information.
# ************************************************************

class AddSpecialKeywords < ActiveRecord::Migration
  def self.up
    #for apartment call back
    Keyword.create :value => 'c'
    #for apartment pics
    Keyword.create :value => 'p'
  end

  def self.down
  end
end
