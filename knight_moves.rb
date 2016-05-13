class Chess
	attr_accessor :gameboard
	def initialize
		create_gameboard
		puts @gameboard.to_s
		@knight= Knight.new([3,4])
	end
	
	class Knight
		attr_accessor :position, :possible_positions
		def initialize(position)
			@position = position
			@legal_moves = [[1,2],[-1,2],[1,-2],[-1,-2],[2,1],[-2,1],[2,-1],[-2,-1]]
			calculate_possible_positions
			knight_tree
		end

		def calculate_possible_positions
		# creates an array of every possible next position 
		# for an instance of a knight	
			@possible_positions = []
			@legal_moves.each do |m|
				@possible_positions << [(self.position[0] + m[0]),(self.position[1]+m[1])]
			end			
		end

		def knight_tree

			self.possible_positions.map! do |p|
				Knight.new(p) if @gameboard.include?(p)
			end
			puts self.possible_positions
		end


	end
	
	def create_gameboard
		@gameboard = []
		8.times do |i|
			8.times do |x|
				@gameboard << [i,x]
			end
		end				
	end



	# def knight_moves(start,final)
	# 	@knight = Knight.new(start)
	# end

end


chess = Chess.new
