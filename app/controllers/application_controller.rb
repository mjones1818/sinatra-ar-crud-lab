
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :index
  end

  get "/articles" do
    @articles = Article.all
    erb :index
  end

  get '/articles/new' do
    erb :new
  end

  post '/articles' do
    Article.create(params)
    redirect "/articles/#{Article.last.id}"
  end

  get '/articles/:id/edit' do
    erb :edit
  end

  patch '/articles/:id' do
    article = Article.find_by_id(params[:id])
    article.update(params[:article])
    article.save
    redirect "/articles/#{article.id}"
  end

  delete '/articles/:id' do
    article = Article.find_by_id(params[:id])
    article.destroy
    redirect '/articles'
  end

  get '/articles/:id' do
    @article = Article.find_by_id(params[:id])
    erb :show
  end
end
