# coding: utf-8
class Application < Sinatra::Application
  set server: 'thin'
  set publisher: Publisher.new

  get '/stream', provides: 'text/event-stream' do
    stream :keep_open do |out|
      settings.publisher.subscribe(params[:channel].to_s, params[:event].to_s, out)
      out.callback do
        settings.publisher.unsubscribe(params[:channel].to_s, params[:event].to_s, out)
      end
      out.errback do
        settings.publisher.unsubscribe(params[:channel].to_s, params[:event].to_s, out)
      end
    end
  end

  post '/publish' do
    logger.info "publishing to #{params[:channel]} - #{params[:event]}"
    settings.publisher.broadcast(params[:channel].to_s, params[:event].to_s, params[:data].to_s)
    204 # response without entity body
  end

  #render page that listens to testchannel, testevent
  get '/test' do
    erb :test
  end
  
  get '/connections' do
    settings.publisher.to_s
  end
end

