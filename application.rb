# coding: utf-8
class Application < Sinatra::Application
  set server: 'thin'
  set publisher: Publisher.new

  get '/stream', provides: 'text/event-stream' do
    stream :keep_open do |stream|
      settings.publisher.new_connection(params[:channel].to_s, params[:event].to_s, stream)
    end
  end

  post '/publish' do
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