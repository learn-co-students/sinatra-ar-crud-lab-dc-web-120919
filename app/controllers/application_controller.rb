
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    #set homepage/index here 
    redirect to '/articles'
  end

  #main 
  get '/articles' do 
    @articles = Article.all #need to get all article objects first 
    erb :index  
  end 

   #new
  get '/articles/new' do  

    erb :new 
  end 

  #creates post after new 
  post '/articles' do 
    title = params[:title]
    content = params[:content]
    @article = Article.create(title: title, content: content) #pass all params to this instance and save it 
    redirect to "/articles/#{@article.id}" #uses newly created @article object's id 
  end 

  #shows a specific article
  get '/articles/:id' do 
    @article = Article.find(params[:id])
    erb :show 
  end 

  #edit article
  get '/articles/:id/edit' do 

    @article = Article.find(params[:id])
    erb :edit 
  end 

  #updates entry 
  patch '/articles/:id' do 
    title = params[:title]
    content = params[:content]
    article = Article.find(params[:id])
    article.update(title: title, content: content)
    redirect to "/articles/#{article.id}"
  end 

  delete '/articles/:id' do 

    Article.delete(params[:id])
    redirect to '/articles'
  end 

  
end
