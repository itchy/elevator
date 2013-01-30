class Elevator
	attr_accessor :current_floor

	def initialize(floor)
		@current_floor = floor
	end

	def call(floor)
		@current_floor = floor
	end

end  


describe "Elevator" do
	context "elevator is on floor 1" do
		before do
			@elevator = Elevator.new(1)
		end
	  it "responds to calls" do
	  	@elevator.call(3)
	  	@elevator.current_floor.should be 3
	  end  
  end 
end  