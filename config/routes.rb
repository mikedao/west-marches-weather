Rails.application.routes.draw do
  get '/', to: 'weathers#show'
  get '/admin', to: 'weathers#index'
  delete '/weather', to: 'weathers#destroy'
  post '/weather', to: 'weathers#create'
end
