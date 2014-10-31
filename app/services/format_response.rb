class FormatResponse

  def initialize(events)
    @events = events
  end

  def format(category)
    self.send(category)
  end

  private

  def digest
    @events.inject([]) do |result, event|
      result << event.data
      result
    end
  end

end 
