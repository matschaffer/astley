require 'rubygems'
require 'rack-legacy'

# A rack adapter for Astley based on Rack::Legacy::Cgi
# Since an Astley app is just a single script and handles
# it's own headers, we override some of the file name
# checking and header injection
class Rack::Astley < Rack::Legacy::Cgi
  def initialize(script)
    super(nil, nil)
    @script = script
  end

  def call(env)
    run env, @script
  end

  def run(env, script)
    response = Rack::Response.new
    response.write super[2].join
    response.finish
  end
end

run Rack::Astley.new './index.cgi'
