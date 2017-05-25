#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database, "sqlite3:barbershop.db"

class Client < ActiveRecord::Base
	validates :name, { :presence => true, :length => { :minimum => 3 } }
	validates :phone, { :presence => true }
	validates :datestamp, { :presence => true }
	validates :color, { :presence => true }
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
	@c = Client.new
	erb :visit
end

post '/visit' do
	# username = params[:username]
	# phone = params[:phone]
	# date = params[:datetime]
	# color = params[:color]
	# barber = params[:barber]

	# # автозаполнение введенных полей при повтороном вводе

	 hh = { :name => 'Введите имя', 
	 		:phone => 'Введите телефон', 
	 		:datestamp => 'Выберите дату' }

	# для каждой пары ключ-значение 
	#hh.each do |key, value|

	# 	if params[key] == ''
	# 		@error = value

	# 		return erb :visit 
	# 	end 
	# end

	# Можно объединить сообщения об ошибках
	# @error = hh.select { |key,_| params[key] == '' }.values.join(",")

	# Запись на прием
	# Client.create :name => username, :phone => phone, :datestamp => date, :barber => barber, :color => color

	# Альтеннативная запись на прием (как у журавля)
	# c = Client.new
	# c.name = username
	# c.phone = phone
	# c.date = date
	# c.barber = barber
	# c.color = color
	# c.save

	# Тру способ записи всего, что выше.

	@c = Client.new params[:client] # сместо :client можно написать все что угодно
	#c.save

	# проверка введенных параметров на пустоту
	
	# hh.each do |key,value|
	# 	if c.errors.messages[key].size > 0 # ActiveRecord создает хэш с ошибками errors.messages
	# 		@error = value

	# 		return erb :visit
	# 	end
	# end

	# проверка журавля
	if @c.save 
		erb "<h2>Спасибо! Вы записались #{c.datestamp}</h2>"
	else
		@error = @c.errors.full_messages.first
		erb :visit
	end
end

get '/contacts' do
  erb :contacts
end

post '/contacts' do
	email = params[:email]
	text = params[:text]

	Contact.create :email => email, :text => text

	erb "Ваше сообщение отправлено!"
end

# должно быть отображение записанных клиентов к конткретному барберу
get '/barbers/:id' do
	@barber = Barber.find(params[:id])
	@clients = Client.joins("INNER JOIN barbers ON barbers.name = clients.barber AND barbers.id =", params[:id]).order("datestamp asc")

	erb :cl_list
end