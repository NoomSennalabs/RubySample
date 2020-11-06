deployer = ENV.fetch("DEPLOYER") { "deploy" }
app_name = ENV.fetch("APP_NAME") { "ruby_sample" }

# frozen_string_literal: true
# Puma can serve each request in a thread from an internal thread pool.
# The `threads` method setting takes two numbers a minimum and maximum.
# Any libraries that use thread pools should be configured to match
# the maximum value specified for Puma. Default is set to 5 threads for minimum
# and maximum, this matches the default thread size of Active Record.
#
threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }.to_i
threads threads_count, threads_count

# Specifies the `port` that Puma will listen on to receive requests, default is 3000.
#
# port        ENV.fetch("PORT") { 3000 }

# Specifies the `environment` that Puma will run in.
#
environment ENV.fetch("RAILS_ENV") { "development" }

# Specifies the number of `workers` to boot in clustered mode.
# Workers are forked webserver processes. If using threads and workers together
# the concurrency of the application would be max `threads` * `workers`.
# Workers do not work on JRuby or Windows (both of which do not support
# processes).
#
workers ENV.fetch("WEB_CONCURRENCY") { 2 }

# Location of pid file
state_path "/home/#{deployer}/apps/#{app_name}/shared/tmp/pids/puma.state"

# Allow workers to reload bundler context when master process is issued
# a USR1 signal. This allows proper reloading of gems while the master
# is preserved across a phased-restart. (incompatible with preload_app)
# (off by default)
#
# FIX - causing problems in integration
# prune_bundler

# Use the `preload_app!` method when specifying a `workers` number.
# This directive tells Puma to first boot the application and load code
# before forking the application. This takes advantage of Copy On Write
# process behavior so workers use less memory. If you use this option
# you need to make sure to reconnect any threads in the `on_worker_boot`
# block.
#
# preload_app!

# The code in the `on_worker_boot` will be called if you are using
# clustered mode by specifying a number of `workers`. After each worker
# process is booted this block will be run, if you are using `preload_app!`
# option you will want to use this block to reconnect to any threads
# or connections that may have been created at application boot, Ruby
# cannot share connections between processes.
#
# on_worker_boot do
#   ActiveRecord::Base.establish_connection if defined?(ActiveRecord)
# end

# Release Directory : https://github.com/puma/puma

# If your symlink releases into a common working directory (i.e., /current
# from Capistrano), Puma won't pick up your new changes when running phased
# restarts without additional configuration. You should set your working
# directory within Puma's config to specify the directory it should use.
# This is a change from earlier versions of Puma (< 2.15) that would infer
# the directory for you.

directory "/home/#{deployer}/apps/#{app_name}/current"

# Allow puma to be restarted by `rails restart` command.
# plugin :tmp_restart
