Rails.application.routes.draw do
  root 'projects#index'
  
  resources :members do
    post :add_project, on: :member
  end

  resources :teams do
    get :members, on: :member
  end

  resources :projects
end
