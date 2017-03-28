Rottenpotatoes::Application.routes.draw do
  resources :Meetr

  root :to => redirect('/Meetr')
  

  
end