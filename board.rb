class Board
    attr_reader :tiles

    def initialize
        @tiles = create_board
    end

    private

    def create_board
        board = []
        8.times do |i|
            8.times do |j|
                board << [i+1,j+1]
            end
        end
        board
    end
end