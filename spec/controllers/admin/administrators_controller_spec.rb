# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Admin::AdministratorsController, type: :controller do
  let (:administrator) { @admin = create :administrator }

  before do
    sign_in administrator
  end

  describe 'GET #index' do
    it 'loads the index view' do
      process :index, method: :get
      expect(response).to render_template(:index)
    end

    it 'loads successfully with an HTTP 200 status code' do
      process :index, method: :get

      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it 'loads an array of administrators' do
      admins = create_list(:administrator, 3)
      process :index, method: :get

      expect(assigns(:administrators)).to match_array(admins << @admin)
    end
  end

  describe 'GET #new' do
    it 'loads the new view' do
      process :new, method: :get
      expect(response).to render_template(:new)
    end

    it 'loads successfully with an HTTP 200 status code' do
      process :new, method: :get

      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET #edit' do
    before do
      @administrator = create(:administrator)
    end

    it 'loads the edit view' do
      process :edit, method: :get, params: { id: @administrator }
      expect(response).to render_template(:edit)
    end

    it 'loads successfully with an HTTP 200 status code' do
      process :edit, method: :get, params: { id: @administrator }

      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it 'loads the right administrator' do
      process :edit, method: :get, params: { id: @administrator }

      expect(assigns(:administrator)).to eq(@administrator)
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates an administrator' do
        expect {
          process :create, method: :post, params: { administrator: attributes_for(:administrator) }
        }.to change(Administrator, :count).by(1)
      end

      it 'redirects to the index view' do
        process :create, method: :post, params: { administrator: attributes_for(:administrator) }

        expect(response).to redirect_to(admin_administrators_path)
      end
    end

    context 'with invalid attributes' do
      it 'does not create an administrator' do
        expect {
          process :create, method: :post, params: { administrator: attributes_for(:administrator, password: nil) }
        }.to_not change(Administrator, :count)
      end

      it 're-renders the new view' do
        process :create, method: :post, params: { administrator: attributes_for(:administrator, password: nil) }

        expect(response).to render_template(:new)
      end
    end
  end

  describe 'PUT #update' do
    before do
      @administrator = create(:administrator, password: 'password')
    end

    context 'with valid attributes' do
      it 'updates the administrator' do
        process :update, method: :put, params: { id: @administrator, administrator: attributes_for(:administrator, first_name: 'Phoenix') }

        @administrator.reload
        expect(assigns(:administrator).first_name).to eq('Phoenix')
      end

      it 'redirects to the index view' do
        process :update, method: :put, params: { id: @administrator, administrator: attributes_for(:administrator, first_name: 'Phoenix', current_password: 'password') }

        expect(response).to redirect_to(admin_administrators_path)
      end
    end

    context 'with invalid attributes' do
      it 'does not update the administrator' do
        process :update, method: :put, params: { id: @administrator, administrator: attributes_for(:administrator, first_name: nil) }

        @administrator.reload
        expect(@administrator.first_name).to_not eq(nil)
        expect(assigns(:administrator)).to eq(@administrator)
      end

      it 're-renders the edit view' do
        process :update, method: :put, params: { id: @administrator, administrator: attributes_for(:administrator, first_name: nil) }

        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'with valid attributes' do
      before do
        @administrator = create(:administrator)
      end

      it 'deletes the administrator' do
        expect {
          process :destroy, method: :delete, params: { id: @administrator }
        }.to change(Administrator, :count).by(-1)
      end

      it 'redirects to the index view' do
        process :destroy, method: :delete, params: { id: @administrator }

        expect(response).to redirect_to(admin_administrators_path)
      end
    end

    context 'with invalid attributes' do
      it 'does not delete the administrator' do
        expect {
          process :destroy, method: :delete, params: { id: @admin }
        }.to_not change(Administrator, :count)
      end

      it 'redirects to the index view' do
        process :destroy, method: :delete, params: { id: @admin }

        expect(response).to redirect_to(admin_administrators_path)
      end
    end
  end
end
