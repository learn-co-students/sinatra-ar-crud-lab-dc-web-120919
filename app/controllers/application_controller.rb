
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    redirect '/articles'
  end

  get "/articles" do
    @articles = Article.all
    erb :index
  end

  get "/articles/new" do
    @articles = Article.new
    erb :new
  end

  get "/articles/:id/edit" do
    @article = Article.find(params[:id])
    erb :edit
  end
  
  get "/articles/:id" do
    @article = Article.find(params[:id])
    erb :show
  end

  post "/articles" do
    title = params[:title]
    content = params[:content]
    @article = Article.find_or_create_by(title: title, content: content)
    redirect "/articles/#{@article.id}"
  end

  patch '/articles/:id' do
    title = params[:title]
    content = params[:content]
    article = Article.find(params[:id])
    article.update(title: title, content: content)
    redirect "/articles/#{article.id}"
  end

  delete "/articles/:id" do
    @article = Article.delete(params[:id])
    redirect "/articles"
  end
end

