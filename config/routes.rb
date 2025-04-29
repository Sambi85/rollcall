Rails.application.routes.draw do
  resources :effects, only: [ :index, :show, :create, :update, :destroy ]
  resources :special_events, only: [ :index, :show, :create, :update, :destroy ]

  resources :trackers, only: [ :create, :show, :update ] do
    member do
      put "next_round"
      get "get_initiative_order"
      get "get_dead_combatants"
    end
    resources :creatures, only: [ :create, :show, :update ] do
      post "creatures"
      put "mark_dead"
      put "mark_alive"
      put "receive_damage"
      put "heal"
      put "reset_death_saves"
      put "add_death_save"
      resources :effects, controller: "creature_effects"
    end
  end

  # Health check route
  get "up" => "rails/health#show", as: :rails_health_check
end
