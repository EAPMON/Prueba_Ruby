module Games
	class Puzzle
		include Mongoid::Document

		field :objetive, type: Array, default: [] #matriz objetivo
		field :puzzle, type: Array, default: [] #matriz puzzle
		field :positionX, type: Integer # posicion casilla vasia  en x
		field :positionY, type: Integer #posicion casilla vasia  en y
		field :size, type: Integer #tamaño del puzzle
		field :pid, type: String

		index({ pid: 1 }, unique: true)
	end
end