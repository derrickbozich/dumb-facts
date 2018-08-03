class FactsController < Sinatra::Base
  get '/:username/facts' do

  end

  get '/:username/facts/:id' do

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
    @user = User.find_by(:username => params['username'])
    fact = (params['id'].to_i)-1
    @fact = @user.facts[fact]

    if params['content'] == ""
      redirect '/:username/facts/:id/edit'
    else
      
    end


  end



  get '/facts' do

  end

  post '/facts' do

  end

  get '/facts/new' do

  end
end
