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
    else

      redirect '/login'
    end
    redirect '/facts'
  end

  get '/logout' do

    if logged_in?

      session.clear
      
      redirect '/login'

    else
      redirect '/login'
    end
  end

  # DO I NEED A POST AND ERB FOR LOGOUT?

  get '/signup' do
    erb :'users/create_user'
  end

  post '/signup' do
    if params['username'] == "" || params['email'] == "" || params['password'] == ""
      redirect "/signup"
    else
      @user = User.create(params)
      session[:user_id] = @user.id
      redirect '/facts'
    end

  end




end
