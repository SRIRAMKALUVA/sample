#https://guides.rubyonrails.org/routing.html
resources :controller_name - generates all the possible 7 routes | to serve dynamic content
resource :controller - exclude index  | t0 serve statci content

resources :users do
  collection do
    # static urls define here
    get :sigin  # /users/signin
    post :signup # /users/signup
  end
  member do
    # dynamic urls
    get :history , constraints: {id: /^\D\d{3}\D{2}/ }#/users/:id/history
    get :image # /users/:id:image
  end
end


get
post
put
patch
delete

match "/hello" , to: "controller#action"


constraints: {id: format}

custom url : /user/:name/action/:title

get "users/:id/image/:image_name", to: "users#image"
@user = User.find(params[:id])
@user.images.where(title: parmas[:image_name])

only
except
format

namespace
namespace :api do
  resources :users, except: [:new, :edit]
end
scope # scope will help you to remove the folder name from the url

scope module 'api' do
  resources :users
end

resource :geocoder
resolve('Geocoder') { [:geocoder] }

/sriram/new
resolve('sriram') { [:users] }

via: :all
get '/stories', to: redirect('/articles')
mount AdminApp, at: '/admin' #, Rails Engine

direct :homepage do
  "http://www.rubyonrails.org"
end
