#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database, "sqlite3:barbershop.db"

class Client < ActiveRecord::Base
end

class Barber < ActiveRecord::Base
end

class Contact < ActiveRecord::Base
end  

before do
	@barbers = Barber.all
end

get '/' do
	erb :index
end

get '/visit' do
	erb :visit
end

post '/visit' do
	username = params[:username]
	phone = params[:phone]
	date = params[:datetime]
	color = params[:color]
	barber = params[:barber]

	# автозаполнение введенных полей при повтороном вводе

	hh = { 	:username => 'Введите имя', 
			:phone => 'Введите телефон', 
			:datetime => 'Выберите дату' }

	# для каждой пары ключ-значение 
	hh.each do |key, value|

		if params[key] == ''
			@error = value

			return erb :visit 
		end 
	end

	# Можно объединить сообщения об ошибках
	# @error = hh.select { |key,_| params[key] == '' }.values.join(",")

	Client.create :name => username, :phone => phone, :datestamp => date, :barber => barber, :color => color

	# db = get_db
	# db.execute 'insert into users 
	# 	(
	# 		name,
	# 		phone,
	# 		datestamp,
	# 		barber,
	# 		color
	# 	)
	# 	values (?,?,?,?,?)', [@username, @phone, @date, @barber, color]

	erb "<h2>Спасибо! Вы записались #{date}</h2>"
	
end