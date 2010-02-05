require 'rubygems'
require 'sinatra'
require 'active_record'

class Talk < ActiveRecord::Base
	validates_presence_of :title
end

configure do
  db_config = YAML.load_file('config/database.yml')
  ActiveRecord::Base.establish_connection(db_config[ENV['RACK_ENV'] || 'production'])
end

before do
	headers "Content-Type" => "text/html; charset=utf-8"
end

helpers do
  def cycle
    %w{even odd}[@_cycle = ((@_cycle || -1) + 1) % 2]
  end
end

get '/' do
  @talks = Talk.all(:order => 'created_at DESC')
	erb :home
end

post '/talks' do
	talk = Talk.new(:title => params[:title])
	talk.save
	redirect '/'
end