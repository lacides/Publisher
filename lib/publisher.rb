class Publisher
  def initialize
    @connections = {}
  end

  def subscribe(channel, event, stream)
    @connections[channel] ||= {}
    @connections[channel][event] ||= []
    @connections[channel][event] << stream
    stream
  end

  def unsubscribe(channel, event, stream)
    if @connections[channel] && @connections[channel][event]
      @connections[channel][event].delete(stream)
      @connections[channel].delete(event) if @connections[channel][event].empty?
      @connections.delete(channel) if @connections[channel].empty?
    end
    stream
  end

  def streams(channel, event)
    if @connections[channel]
      @connections[channel][event] || []
    else
      []
    end
  end

  def broadcast(channel, event, data)
    streams(channel, event).each{|stream| stream << "data: #{data}\n\n"}
  end

  def to_s
    @connections.keys.inject({}) do |result, channel|
      result[channel] = @connections[channel].keys
      result
    end.to_s
  end
end