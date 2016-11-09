Glico::Application.routes.draw do
  #captcha_route  #验证码路由

  root :to => 'home#index'

  match '/auth/:provider/callback', to: 'sns_sessions#create'
  match '/auth/failure', to: 'sns_sessions#failure' 

  match '/activity'             =>'home#activity'
  match '/presentation'         =>'home#presentation'
  match '/signup'               =>'users#add',               :as =>:signup,  :via =>:get
  match '/signup_success'       =>'users#add_success',       :as =>:signup_success, :via =>:post
  match '/sessions/create'      =>'sessions#create',         :as =>:dologin, :via =>:post
  match '/sessions/destroy'     =>'sessions#destroy',        :via =>:post
  match '/users/forgot_pwd'     =>'sessions#forgot_pwd',     :via =>:post #忘记密码
  match '/users/reset_password' =>'sessions#reset_password'
  match '/users/reset_pwd_sure' =>'sessions#reset_pwd_sure', :via =>:post
  match '/users/active'         =>'sessions#active_user',    :via =>:get  #用户激活
  match '/users/check_email'    =>'users#check_email',       :via =>:get  #用户激活
  match '/users/join_campaign'  =>'users#join_campaign',     :via =>:post #用户参与活动
  match '/users/join_campaign1' =>'users#join_campaign1',    :via =>:post #用户参与活动
  match '/users/me'  =>'users#me',     :via =>:get #用户 from static html

  match '/users/:id/edit'       =>'users#edit',              :via=> :get, :as =>:edituser
  match '/users/:id/update'     =>'users#update',            :via=> :put, :as =>:updateuser
  match '/users/:id/withdraw'   =>'users#withdraw',          :via=> :put, :as =>:withdraw_user
  match '/users/:id'            =>'users#show',              :as => :mypage,  :via =>:get #mypage

  match '/widget/index'         =>'sessions#widget_index'
  match '/widget/login'         =>'sessions#widget'
  match '/widget/logined'       =>'sessions#widget_login', :as => :widgetlogin, :via =>:post

  match '/users/update_email_from_auth' =>'users#auth_update_email', :via =>:put


  namespace :admin do
    root :to =>'sessions#index'
    match 'login'            =>'sessions#new',      :as  =>:login
    match '/sessions/create' =>'sessions#create',   :as =>:logined
    match 'logout'           =>'sessions#destroy',  :as =>:logout

    match '/campaign/add_award_user' =>'award#add_user', :as =>:addawarduser
    match '/campaign/award_csv_user' =>'award#add_award_csv_user', :via =>:post, :as =>:addawardcsv

    resources :topimages do
      collection do
        post 'position'
      end
    end

    resources :campaigns
    resources :news

  end #namespace /admin


end
