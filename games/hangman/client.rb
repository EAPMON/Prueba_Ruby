# reto 2

require 'net/http'
require 'json'

class Client
  def initialize; end

  def conection(pid)
    @datos = Net::HTTP.get_response('localhost', "/hangman/#{pid}", 9292)
    @datos = JSON.parse(@datos.body)
  end

  def log(pid)
    while @datos[':state'] == 'playing' || @datos[':win'] == false
      puts 'letra'
      letra = gets.chomp
      @datos = Net::HTTP.get_response('localhost', "/hangman/#{pid}/try/" + letra, 9292)
      @datos = JSON.parse(@datos.body)
      puts JSON.pretty_generate(@datos)
      puts 'Enter para continuar'
      gets.chomp
    end
  end

  def isWin
    if @datos[':state'] == 'lose'
      puts `clear`
      puts 'PERDISTE'

    else
      puts `clear`
      puts 'GANASTE'
    end
  end
end
