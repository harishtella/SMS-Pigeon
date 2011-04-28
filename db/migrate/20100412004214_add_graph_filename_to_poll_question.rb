# ************************************************************
# written by: Harish Tella (ht@harishtella.info)
# [Copyright (C) 2010 Harish Tella, All rights reserved.]
# see included document, "license.txt", for more information.
# ************************************************************

class AddGraphFilenameToPollQuestion < ActiveRecord::Migration
  def self.up
    add_column :poll_questions, :graph_filename, :string
  end

  def self.down
    remove_column :poll_questions, :graph_filename
  end
end
