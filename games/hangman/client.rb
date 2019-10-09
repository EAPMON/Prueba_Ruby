# reto 2

require 'net/http'
require 'json'

puts 'pid'
pid = gets.chomp

datos = Net::HTTP.get_response('localhost', "/hangman/#{pid}", 9292)
datos = JSON.parse(datos.body)
while(datos[':state'] == "playing" || datos[':win'] == false)
	puts "letra"
	letra = gets.chomp
  datos = Net::HTTP.get_response('localhost', "/hangman/#{pid}/try/" + letra, 9292)
  datos = JSON.parse(datos.body)
  puts JSON.pretty_generate(datos)
  puts "Enter para continuar"
  gets.chomp
end

if datos[":state"] == "lose"
  puts "Perdiste"
else
  puts "Ganaste"
end

