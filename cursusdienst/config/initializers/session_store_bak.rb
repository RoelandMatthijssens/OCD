# Be sure to restart your server when you modify this file.

Cursusdienst::Application.config.session_store :cookie_store, :key => '_cursusdienst_session', :domain => ".badger.rave.org"


# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rails generate session_migration")
# Cursusdienst::Application.config.session_store :active_record_store