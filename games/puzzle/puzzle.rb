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

    def right(game)
      if (game.positionY != game.size - 1)
        aux = game.puzzle[game.positionX][game.positionY + 1]
        game.puzzle[game.positionX][game.positionY + 1] = 0
        game.puzzle[game.positionX][game.positionY] = aux
        game.positionY = game.positionY + 1
        game.save
        return nil
      end
    end

    def left(game)
      if (game.positionY != 0)
        aux = game.puzzle[game.positionX][game.positionY - 1]
        game.puzzle[game.positionX][game.positionY - 1] = 0
        game.puzzle[game.positionX][game.positionY] = aux
        game.positionY = game.positionY - 1
        game.save
        return nil
      end
    end

    def up(game)
      if (game.positionX != 0)
        aux = game.puzzle[game.positionX - 1][game.positionY]
        game.puzzle[game.positionX - 1][game.positionY] = 0
        game.puzzle[game.positionX][game.positionY] = aux
        game.positionX = game.positionX - 1
        game.save
        return nil
      end
    end

    def down(game)
      if (game.positionX != game.size - 1)
        aux = game.puzzle[game.positionX + 1][game.positionY]
        game.puzzle[game.positionX + 1][game.positionY] = 0
        game.puzzle[game.positionX][game.positionY] = aux
        game.positionX = game.positionX + 1
        game.save
        return nil
      end
    end
  end
end
