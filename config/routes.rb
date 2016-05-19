Rails.application.routes.draw do
  get 'welcome/index'

  get 'welcome/about'

  get 'welcome/faq'

  get 'welcome/contact'

  root 'welcome#index'
end
