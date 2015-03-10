# This rack file has 2 middleware filters and an empty app
# 1) Rack-rewrite to append "/index.html" to URLs without "."
# 2) Rack::Static to serve static files

require 'rack/rewrite'
use Rack::Rewrite do
  r301 %r{^([^\.]*[^\/])$}, '$1/'
  r301 %r{^(.*\/)$}, '$1index.html'
  r301 '/es.html', '/es/index.html'
end

use Rack::Static, :urls => ["/"]

# Empty app, should never be reached:
class ProRubyTeam
  def call(env)
    [200, {"Content-Type" => "text/html"}, ["Ouch, broken link! Please report to http://prorubyteam.com/"] ]
  end
end
run ProRubyTeam.new
