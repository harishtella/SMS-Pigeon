# ************************************************************
# written by: Harish Tella (ht@harishtella.info)
# [Copyright (C) 2010 Harish Tella, All rights reserved.]
# see included document, "license.txt", for more information.
# ************************************************************

class CreatePollVotes < ActiveRecord::Migration
  def self.up
    create_table :poll_votes do |t|
      t.integer :poll_choice_id
      t.integer :user_id
      t.timestamps
    end
  end

  def self.down
    drop_table :poll_votes
  end
end
