# frozen_string_literal: true
RSpec.shared_examples :post_create do |option|
  let (:invalidation) { option[:invalid] }

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates the object' do
        expect {
          process :create, method: :post, params: { controller_model_name => attributes_for(controller_model_name) }
        }.to change(controller_model, :count).by(1)
      end

      it 'redirects to the index' do
        process :create, method: :post, params: { controller_model_name => attributes_for(controller_model_name) }

        expect(response).to redirect_to(send("admin_#{plural_controller_model_name}_path"))
      end
    end

    if option[:invalid].present?
      context 'with invalid attributes' do
        it 'does not create the object' do
          expect {
            process :create, method: :post, params: { controller_model_name => attributes_for(controller_model_name, invalidation) }
          }.to_not change(controller_model, :count)
        end

        if option[:invalid_path].present?
          it 'renders the index view' do
            process :create, method: :post, params: { controller_model_name => attributes_for(controller_model_name, invalidation) }

            expect(response).to redirect_to(send(option[:invalid_path]))
          end
        else
          it 'renders the index view' do
            process :create, method: :post, params: { controller_model_name => attributes_for(controller_model_name, invalidation) }

            expect(response).to render_template(:new)
          end
        end
      end
    end
  end
end
