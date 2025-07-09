Rails.application.routes.draw do
  resources :abilities
  resources :creature_abilities
  resources :ability_usages
  resources :effects
  resources :special_events

  resources :trackers, only: [ :create, :show, :update ] do
    member do
      put "add_combatant" 
      put "next_round"
      get "get_initiative_order"
      get "get_dead_combatants"
    end
    resources :creatures, only: [ :create, :show, :update ] do
      put "mark_dead"
      put "mark_alive"
      put "receive_damage"
      put "heal"
      put "reset_death_saves"
      put "add_death_save"
      resources :effects, controller: "creature_effects"
      resources :creature_abilities
    end
  end

  # Health check route
  get "up" => "rails/health#show", as: :rails_health_check
end
