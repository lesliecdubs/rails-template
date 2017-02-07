# frozen_string_literal: true
Rails.application.routes.draw do
  devise_for :administrators,
  controllers: {
    confirmations: 'admin/confirmations',
    passwords:     'admin/passwords',
    sessions:      'admin/sessions'
  },
  path: 'admin'

  mount RedactorImageUploader::UploadEndpoint => "/images"

  concern :shrine_upload_manager do
    post 'image', action: 'image'
  end

  namespace :admin do
    root 'application#index'

    resources :administrators, except: [:show]
  end
end
