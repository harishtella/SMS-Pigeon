# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_cpmtxt_rails_session',
  :secret      => 'a983acbe12f00efd38be94b61724279816b6a1875e6ab29c1942e48b5bd3bea48f8ee713953ed193393c8865acbc6d2f5a32a57ef6f7298fe4b9c3ad04b4e53e'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
