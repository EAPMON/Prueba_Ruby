# reto 3

module Games
  class PuzzleApi < Sinatra::Base
    get '/puzzle/:pid/:size' do
      @game = Puzzle.where(pid: params[:pid]).first
      if @game.nil?
        size = params[:size].to_i
        limite = size**2
        y = 0
        x = 0
        dataorder = (0..limite -1).to_a
        data = (0..limite -1).to_a.shuffle
        aux = dataorder.shift
        dataorder << aux
        
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
          size: size
        )
        @game.save
      end

      res = "<br>"
      res2  = "<br>"

      @game.puzzle.each_with_index do |e, row, col|
        e.each_with_index do |f, col,|
          res += @game.puzzle[row][col].to_s + " "
          res2 += @game.objetive[row][col].to_s + " "
        end
        res += "<br>"
        res2 += "<br>"
      end

      Oj.dump(
        puzzle: res,
        goal: res2,
      )
    end

    get '/puzzle/:pid/try/:jugada' do
      fails = ""
      win = false
      @game = Puzzle.where(pid: params[:pid]).first
      if @game.nil?
        Oj.dump(
          error: "No existe el juego"
        )
      else
        if params[:jugada] == "der"
          if(@game.positionY != @game.size - 1)
            aux = @game.puzzle[@game.positionX][@game.positionY+1]
            @game.puzzle[@game.positionX][@game.positionY+1] = 0
            @game.puzzle[@game.positionX][@game.positionY] = aux
            @game.positionY = @game.positionY + 1
            @game.save
          else
            error = "Mala jugada"
          end
        elsif params[:jugada] == "izq"
          if(@game.positionY != 0)
            aux = @game.puzzle[@game.positionX][@game.positionY-1]
            @game.puzzle[@game.positionX][@game.positionY-1] = 0
            @game.puzzle[@game.positionX][@game.positionY] = aux
            @game.positionY = @game.positionY - 1
            @game.save
          else
            error = "Mala jugada"
          end
        elsif params[:jugada] == "aba"
          if(@game.positionX != @game.size - 1)
            aux = @game.puzzle[@game.positionX+1][@game.positionY]
            @game.puzzle[@game.positionX+1][@game.positionY] = 0
            @game.puzzle[@game.positionX][@game.positionY] = aux
            @game.positionX = @game.positionX + 1
            @game.save
          else
            error = "Mala jugada"
          end
        elsif params[:jugada] == "arr"
          if(@game.positionX != 0)
            aux = @game.puzzle[@game.positionX-1][@game.positionY]
            @game.puzzle[@game.positionX-1][@game.positionY] = 0
            @game.puzzle[@game.positionX][@game.positionY] = aux
            @game.positionX = @game.positionX - 1
            @game.save
          else
            error = "mala jugada"
          end
        end
        
        res = "<br>"
        res2  = "<br>"
  
        @game.puzzle.each_with_index do |e, row, col|
          e.each_with_index do |f, col,|
            res += @game.puzzle[row][col].to_s + " "
            res2 += @game.objetive[row][col].to_s + " "
          end
          res += "<br>"
          res2 += "<br>"
        end
  
        if res == res2
          win = true
        end
  
        Oj.dump(
          puzzle: res,
          goal: res2,
          fails: error,
          win: win
        )
  
      end
  
  
  end



	end		
end