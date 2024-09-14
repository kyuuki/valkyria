Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  #root "static_page#home"
  #root "sites#home"
  root "posts#index"
  # root to: "static_page#home"  # 上記はこれの省略形

  get "/about", to: "static_page#about"
  get "/team", to: "static_page#team"
  get "/testimonials", to: "static_page#testimonials"
  get "/services", to: "static_page#services"
  get "/portfolio", to: "static_page#portfolio"
  get "/portfolio-details", to: "static_page#portfolio_details"
  get "/pricing", to: "static_page#pricing"
  get "/blog", to: "static_page#blog"
  get "/blog-single", to: "static_page#blog_single"
  get "/contact", to: "static_page#contact"

  resources :posts, only: [:index, :show]

  # AdminLTE
  namespace 'admin' do
    root "static_page#root"
    get "/general_form", to: "static_page#general_form"
    get "/validation", to: "static_page#validation"
    get "/profile", to: "static_page#profile"
    get "/login", to: "static_page#login"
  end
end
