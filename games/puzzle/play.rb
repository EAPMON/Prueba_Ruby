require_relative 'client.rb'

loop do
  puts 'pid'
	pid = gets.chomp
	puts 'size'
	size = gets.chomp
	cliente = Client.new()
	cliente.conection(pid,size)
	cliente.log(pid)
	cliente.isWin()
	puts '¿Desea continuar? [s/n]'
	stop = gets.chomp
  break if stop != 's'
end