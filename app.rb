require 'sinatra'
require 'sinatra/reloader'
require 'data_mapper'

DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/blog.db")

class Question #무조건 대문자, 중요
  include DataMapper::Resource
  property :id, Serial
  property :name, String #text와 비슷, text가 더 많은 글자를 저장할 수 있다.
  property :question, Text
  #property :created_at, DateTime
  
end

DataMapper.finalize
Question.auto_upgrade!
  
get '/' do
    @questions = Question.all
    erb :index
end

get '/ask' do
    @name = params[:name]
    @question = params[:question]
    
    Question.create(
        name: @name,
        question: @question
    )
    
    # erb :ask
    redirect '/'
end