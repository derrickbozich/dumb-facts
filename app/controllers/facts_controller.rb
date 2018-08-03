class FactsController < ApplicationController
  get '/:username/facts' do
    @user = User.find_by_slug(params['username'])
    erb :'facts/user_facts'
  end

  get '/:username/facts/:id' do
    @user = User.find_by_slug(params['username'])
    fact = (params['id'].to_i)-1
    @fact = @user.facts[fact]
    erb :'facts/show'
  end



  get '/:username/facts/:id/edit' do
    @user = User.find_by(:username => params['username'])
    fact = (params['id'].to_i)-1
    @fact = @user.facts[fact]
    if logged_in?
      erb :'facts/edit'
    else
      redirect '/login'
    end
  end

  post '/:username/facts/:id' do
    @user = User.find_by_slug(params['username'])
    @fact_number = (params['id'].to_i)-1
    @fact = @user.facts[@fact_number]

    if params['content'] == ""
      redirect "/#{params['username']}/facts/#{params['id']}/edit"
    else
      @fact.content = params['content']
      @fact.save
      redirect "/#{params['username']}/facts/#{params['id']}"
    end
  end



  get '/facts' do
    erb :'facts/facts'
  end

  get '/facts/new' do
    if logged_in?
      erb :'facts/new'
    else
      redirect '/login'
    end

  end

  post '/facts' do
    if params['content'] != ''
      @user = User.find_by_id(session['user_id'])
      @fact = Fact.create(content: params['content'], user_id: @user.id)
      redirect '/facts'
    else
      redirect '/facts/new'
    end
  end

  post '/:username/facts/:id/delete' do
    @user = User.find_by_slug(params['username'])
    fact = (params['id'].to_i)-1
    @fact = @user.facts[fact]

    @fact.delete
    redirect '/facts'
  end


end
