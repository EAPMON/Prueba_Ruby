require_relative 'client.rb'
loop do
	puts 'pid'
	pid = gets.chomp
	cliente = Client.new()
	cliente.conection(pid)
	cliente.log(pid)
	cliente.isWin()
	puts '¿Desea continuar? [s/n]'
	stop = gets.chomp
  break if stop != 's'
end