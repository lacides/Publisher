# Publisher

## What's this?

A example of Sinatra::Streaming
It serves SSEs in a channel/event schema

## What can you do with it?

For starters, fire it up with thin start or foreman start.  
Then open your SSE/websocket supporting browser (let's go with the latest version of chrome) and hit localhost:3000/test  
You'll be in a page with an open EventSource listening to server sent events trough the channel testchannel and for the event testevent
  
So you can open your irb and:

    require 'net/http'
    uri = URI('http://localhost:3000/publish')
    Net::HTTP.post_form(uri, 'channel' => 'testchannel', 'event' => 'testevent', 'data' => '<br> Hello there')

And look at that, your data is showing up at real-time on your browser

## What's next?

Well, I'd love to put in some of my projects models something like notify_to_publisher and have my model send to Publisher its json representation on each create, update, or destroy. Hey! Those sound like events, right?
Let's say I have a Post model and by dropping notify_to_publisher on it, and now on each CRUD operation the model will send its own json to the server using the post channel on the create, update or delete events.
Yeah, I think that's what I'll do next.