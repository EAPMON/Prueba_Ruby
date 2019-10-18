require "net/http"
require "json"
require_relative "helper.rb"

class Client
  def initialize; end

  def conection(pid, size)
    @datos = Net::HTTP.get_response("localhost", "/puzzle/#{pid}/#{size}", 9292)
    @datos = JSON.parse(@datos.body)
  end

  def log(pid)
    puts `clear`
    puts @datos[":puzzle"]
    while @datos[":m1"] != @datos[":m2"]
      action = ""
      c = read_char
      case c
      when "\e[A"
        action = "arr"
      when "\e[B"
        action = "aba"
      when "\e[C"
        action = "der"
      when "\e[D"
        action = "izq"
      end
      @datos = Net::HTTP.get_response("localhost", "/puzzle/#{pid}/try/#{action}", 9292)
      @datos = JSON.parse(@datos.body)
      puts `clear`
      puts @datos[":puzzle"]
    end
  end

  def isWin()
    puts `clear`
    puts "GANASTE"
  end
end
