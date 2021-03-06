# reto 3

module Games
  class PuzzleApi < Sinatra::Base
    def self.dataOrder(size)
      limite = size ** 2
      dataorder = (0..limite - 1).to_a
      aux = dataorder.shift
      dataorder << aux
      return dataorder
    end

    def self.data(size)
      limite = size ** 2
      data = (0..limite - 1).to_a.shuffle
      return data
    end

    get "/puzzle/:pid/:size" do
      @game = Puzzle.where(pid: params[:pid]).first
      if @game.nil?
        size = params[:size].to_i
        y = 0
        x = 0
        dataorder = PuzzleApi.dataOrder(size)
        data = PuzzleApi.data(size)

        m = Array.new(size) { Array.new(size, 0) }
        mC = Array.new(size) { Array.new(size, 0) }

        m.each_with_index do |e, row|
          e.each_with_index do |f, col|
            m[row][col] = data.pop
            mC[row][col] = dataorder.shift
            if m[row][col] == 0
              x = row
              y = col
            end
          end
        end

        @game = Puzzle.new(
          pid: params[:pid],
          puzzle: m,
          objetive: mC,
          positionX: x,
          positionY: y,
          size: size,
        )
        @game.save
      end

      res = ""
      res2 = "\n"

      @game.puzzle.each_with_index do |e, row, col|
        e.each_with_index do |f, col, |
          res += @game.puzzle[row][col].to_s + " "
          res2 += @game.objetive[row][col].to_s + " "
        end
        res += "\n"
        res2 += "\n"
      end

      Oj.dump(
        puzzle: res,
        goal: res2,
        m1: @game.puzzle,
        m2: @game.objetive,
      )
    end

    get "/puzzle/:pid/try/:jugada" do
      fails = ""
      win = false
      @game = Puzzle.where(pid: params[:pid]).first
      if @game.nil?
        Oj.dump(
          error: "No existe el juego",
        )
      else
        if params[:jugada] == "der"
          @game.right(@game)
        elsif params[:jugada] == "izq"
          @game.left(@game)
        elsif params[:jugada] == "aba"
          @game.down(@game)
        elsif params[:jugada] == "arr"
          @game.up(@game)
        end

        res = ""
        res2 = "\n"

        @game.puzzle.each_with_index do |e, row, col|
          e.each_with_index do |f, col, |
            res += @game.puzzle[row][col].to_s + " "
            res2 += @game.objetive[row][col].to_s + " "
          end
          res += "\n"
          res2 += "\n"
        end

        if res == res2
          win = true
        end

        Oj.dump(
          puzzle: res,
          goal: res2,
          win: win,
          m1: @game.puzzle,
          m2: @game.objetive,
        )
      end
    end
  end
end
