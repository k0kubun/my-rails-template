Rails.application.routes.draw do
  root to: 'application#index'
  get '/page1' => 'application#page1'
  get '/page2' => 'application#page2'
  get '/page3' => 'application#page3'
  get '/page4' => 'application#page4'
  get '/page5' => 'application#page5'
end
