require 'rubygems'
require 'sinatra'

get '/' do
	'Hello World!'
end

get '/barcamp' do
	'Hello BarCamp'
end

get '/hello/:name' do
	"Hello #{params[:name]}"
end

get '/time' do
	erb "The time is <%= Time.now.strftime('%H:%M') %>", :layout => false
end