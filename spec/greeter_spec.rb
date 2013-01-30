class Elevator
  attr_accessor :current_floor

  def initialize(floor)
  	@queue = []
  	@current_floor = floor
  end

  def call(floor)
  	@queue << floor unless @queue.member? floor 
  end

  def tick()
    return if @queue.empty?
  	if @queue.first != @current_floor
  		@current_floor += (@current_floor > @queue.first)?-1:1;
  	end
  end
end  


describe "Elevator" do
	context "elevator is on floor 1" do
		before do
			@elevator = Elevator.new(1)
		end
	  
    it "responds to calls" do
	  	@elevator.call(2)
	  	@elevator.tick()
	  	@elevator.current_floor.should be 2
	  end  

	  it "takes a tic to move" do
	  	@elevator.call(3)
	  	@elevator.tick()
	  	@elevator.current_floor.should be 2
	  	@elevator.tick()
	  	@elevator.current_floor.should be 3
	  end

	  it "queues floors to visit" do
	  	@elevator.call(3)
	  	@elevator.tick
	  	@elevator.call 1
	  	@elevator.tick
	  	@elevator.current_floor.should be 3 #we think
	  end

    it "should remove the current floor from the queue" do
      @elevator.call(2)
      @elevator.tick()
      @elevator.call(3)
      @elevator.tick()
      @elevator.current_floor.should be 3 
    end

  end 
end  