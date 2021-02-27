
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
  end

  get '/articles' do
    @articles = Article.all
    erb :index
  end

  get '/articles/new' do
    erb :new
  end

  get '/articles/:id' do
    @article = Article.find_by(id: params[:id])
    erb :show
  end

  post '/articles' do
    a = Article.create(title: params[:title], content: params[:content])
    redirect :"/articles/#{a.id}"
  end

  get '/articles/:id/edit' do
    @article = Article.find_by(id: params[:id])
    erb :edit
  end

  patch '/articles/:id' do
    a = Article.find_by(id: params[:id])
    a.title = params[:title]
    a.content = params[:content]
    a.save
    redirect :"/articles/#{a.id}"
  end

  delete '/articles/:id' do
    Article.find_by(id: params[:id]).destroy
  end
end
