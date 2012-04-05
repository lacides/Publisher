class Publisher
  def initialize
    @connections = {}
  end

  def new_connection(channel, event, stream)
    @connections[channel.to_sym] ||= {}
    @connections[channel.to_sym][event.to_sym] ||= [] #unless @connections[channel.to_sym][event.to_sym]
    @connections[channel.to_sym][event.to_sym] << stream
  end

  def streams(channel, event)
    if @connections[channel.to_sym]
      @connections[channel.to_sym][event.to_sym] || []
    else
      []
    end
  end

  def broadcast(channel, event, data)
    streams(channel, event).each{|stream| stream << "data: #{data}\n\n"}
  end

  def to_s
    @connections.to_s
  end
end