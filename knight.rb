class Knight
    require_relative "board"
    require_relative "step"

    @@MOVES = [[2,1], [2,-1], [1,2], [1,-2], [-1,2], [-1,-2], [-2,1], [-2,-1]]

    def initialize
        @board = Board.new
        @paths = nil
        
    end

    def knight_moves(start, _end)
        @paths = Step.new(start)
        print_path(find_path(_end, generate_paths(_end)))
    end

    private

    def generate_paths(_end)
        tiles = @board.tiles.dup
        level = [@paths]
        current_positions = level.map { |step| step.position}
        until current_positions.include?(_end)
            next_level = []
            new_positions = []
            level.each do |step|
                new_positions = @@MOVES.map { |move| [move,step.position].transpose.map { |x| x.reduce(:+)}}.select { |new_position| tiles.include?(new_position)}
                step.children = new_positions.map { |new_position| Step.new(new_position, step)}
                next_level << step.children
            end
            tiles -= current_positions
            level = next_level.flatten
            current_positions = level.map { |step| step.position}     
        end
        level.select { |step| step.position == _end}
    end

    def find_path(_end, step)
        path = [step[0]]
        while path[0].parent
            path.prepend(path[0].parent)
        end
        path
    end

    def print_path(path)
        output = "Made it in #{path.length-1} moves! "
        path.each do |step|
            output += "#{step.position} -> "
        end
        puts output[0..-5]
    end
end