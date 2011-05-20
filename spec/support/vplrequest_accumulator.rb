class VPLRequestAccumulator
  
  attr_reader :response
  attr_reader :error
  attr_reader :success_callback
  attr_reader :error_callback
  
  def initialize
    @success_callback = Proc.new { |response| @response = response }
    @error_callback = Proc.new { |error| @error = error }
  end
  
end