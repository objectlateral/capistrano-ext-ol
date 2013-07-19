require "capistrano/ext/ol/version"

unless Capistrano::Configuration.respond_to? :instance
  abort "capistrano/ext/ol requires Capistrano 2"
end

%w(config db passenger resque).each do |recipe|
  require "capistrano/ext/#{recipe}"
end
