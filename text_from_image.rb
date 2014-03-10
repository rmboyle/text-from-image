require 'rubygems'
require 'sinatra'
require 'haml'
require 'json'
require 'open-uri'
require 'tesseract'
require 'uri'

class TextFromImage < Sinatra::Application

  get '/' do
    haml :index
  end

  post '/text_me_bro' do
    e = Tesseract::Engine.new { |e|
                                e.language  = :eng
                                e.blacklist = '|'
                              }
    url = params[:url]
    if url
      image = open(url) {|f| f.read}
      text = e.text_for(image)
      if text
        q = URI.encode_www_form({url: url, text: text})
        redirect "/image?#{q}"
      end
    else
      redirect '/'
    end
  end

  get '/image' do
    haml :image
  end
end