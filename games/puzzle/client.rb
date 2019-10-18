require 'net/http'
require 'json'
require_relative 'helper.rb'

class Client
  def initialize; end

	def conection(pid,size)
		@datos = Net::HTTP.get_response('localhost', "/puzzle/#{pid}/#{size}", 9292)
		@datos = JSON.parse(@datos.body)
  end
	
	def log(pid)
		while @datos[':puzzle'] != @datos[':goal']
			puts JSON.pretty_generate(@datos)
			puts 'accion'
			action = gets.chomp
			@datos = Net::HTTP.get_response('localhost', "/puzzle/#{pid}/try/#{action}", 9292)
			@datos = JSON.parse(@datos.body)
			puts `clear`
			puts @datos[':puzzle']
			#puts JSON.pretty_generate(@datos[':puzzle'])
			c = read_char
			puts c
		
    end
	end
	
	def isWin()
		if @datos[':puzzle'] == @datos[':goal']
      		puts `clear`
			puts 'GANASTE'
		else 
			puts `clear`
			puts 'PERDISTE'
		end
	end

	

end