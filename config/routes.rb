Rails.application.routes.draw do
  # Devise routes for authentication
  devise_for :users

  root to: "projects#index"
  
  resources :projects do
    collection do
      get :archived
    end

    member do
      patch :publish
      patch :archive
      patch :revert_to_draft
      post :upload_files
      delete :delete_file
    end

    resources :questions, except: [:index, :show]

    resources :ratings, only: [:create], defaults: { format: :json }

    resources :comments, only: [:create, :edit, :update, :destroy]
  end

  get "up" => "rails/health#show", as: :rails_health_check
end



