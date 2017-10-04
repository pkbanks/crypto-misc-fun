require 'sinatra'

get '/' do
  File.read(File.join('public', 'graph.html'))
end
