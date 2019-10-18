require 'net/http'
require 'json'

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
      puts JSON.pretty_generate(@datos)
      puts 'Enter para continuar'
      gets.chomp
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