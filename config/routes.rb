Rails.application.routes.draw do
  resources :trackers, only: [:create, :show] do
    member do
      post 'next_round'
      get 'get_initiative_order'
      get 'get_dead_combatants'
    end
    resources :creatures, only: [:create, :show, :update] do
      put 'mark_dead'
      put 'mark_alive'
    end
  end

  # Health check route
  get "up" => "rails/health#show", as: :rails_health_check
end
