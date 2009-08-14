# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_contacts_session',
  :secret      => '4ff22849927d6ec9ab97389fb8b040751d55e4deee24674b9f668f39e473dcf5e71e8b9799dcf5367a2c525d4b5fba990949c5245e716e9cbbf3eb4cc804d215'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
