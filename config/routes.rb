Rails.application.routes.draw do
  get "pages/home"
  get "/dashboard", to: "dashboards#show"
  root "pages#home"

  resources :abilities
  resources :creatures, only: :index
  resources :creature_abilities
  resources :ability_usages
  resources :effects
  resources :special_events

  resources :trackers, only: [ :create, :show, :update ] do
    member do
      put "add_combatant"
      put "next_round"
      put :next_turn
      get "get_initiative_order"
      get "get_dead_combatants"
      get :resume
    end
    resources :creatures, only: [ :create, :index, :show, :update ] do
      put "mark_dead"
      put "mark_alive"
      put "receive_damage"
      put "heal"
      put "reset_death_saves"
      put "add_death_save"
      put "update_health"
      get :hp_controls

      resources :effects, controller: "creature_effects"
      resources :creature_abilities
    end
  end

  # Health check route
  get "up" => "rails/health#show", as: :rails_health_check
end
