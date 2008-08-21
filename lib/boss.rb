$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'boss/api'
require 'boss/config'
require 'boss/result'
require 'boss/result_collection'
require 'boss/result_factory'
require 'boss/version'

module Boss
  YAHOO_VERSION = 1
 
  class BossError < StandardError; end
  class InvalidFormat < StandardError; end
  class InvalidConfig < StandardError; end
end