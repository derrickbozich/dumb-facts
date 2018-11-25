class UsersController < ApplicationController
  get '/login' do
    if logged_in?
      redirect '/facts'
    else
      erb :'users/login'
    end
  end

  post '/login' do
    @user = User.find_by(:username => params['username'])
    if @user && @user.authenticate(params['password'])
      session[:user_id] = @user.id
      redirect '/facts'
    else
      @error = 'incorrect username or password'
      erb :'users/login'
    end

  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect '/login'
    else
      redirect '/facts'
    end
  end

  get '/signup' do
    erb :'users/create_user'
  end

  post '/signup' do
    if (params['username'] == "" || params['email'] == "" || params['password'] == "" )
      @error = "Please fill out all fields"
      erb :'users/create_user'
    elsif User.find_by(email: params['email'])
      @error = "User emails must be unique"
      erb :'users/create_user'
    else
      @user = User.create(params)
      session[:user_id] = @user.id
      redirect '/facts'
    end

  end
end
