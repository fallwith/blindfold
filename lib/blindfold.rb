class Blindfold
  require 'spec'
  require 'machinist/active_record'
  require 'sham'
  require 'forgery'
  require 'rack/test'
  require 'nokogiri'
  
  require 'blindfold/launcher'
  require 'blindfold/connection'
  require 'blindfold/spec'
  require 'blindfold/xml'
  require 'blindfold/helpers'
  
  mattr_accessor :config_dir
  mattr_accessor :rails_root
  mattr_accessor :boot_redis
  
  @@config_dir = File.dirname(__FILE__) + '/../config'
  @@rails_root = nil
  @@boot_redis = false
end