require 'sinatra'

class DisruptionsMap < Sinatra::Base
  get '/' do
    haml :display_map
  end
end
# AIzaSyD8eKPDmhw2kwEeNVG4RbqfBIXGtz-WZ54