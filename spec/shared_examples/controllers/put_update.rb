# frozen_string_literal: true
RSpec.shared_examples :put_update do |options|
  let (:invalidation) { options[:invalid] }
  let (:update)       { options[:update] }
  let (:model_traits) { options[:model_traits] || [] }

  describe 'PUT #update' do
    before do
      @model = create controller_model_name, *model_traits
    end

    context 'with valid attributes' do
      it 'updates the object' do
        process :update, method: :put, params: { id: @model.id, controller_model_name => attributes_for(controller_model_name, update) }
        @model.reload

        update.each do |k, v|
          expect(@model.send(k)).to eq(v)
        end
      end

      if options[:valid_redirect].present?
        it 'redirects to path' do
         process :update, method: :put, params: { id: @model.id, controller_model_name => attributes_for(controller_model_name, update) }

         expect(response).to redirect_to(send(options[:valid_redirect]))
        end
      else
        it 'redirects to the index' do
         process :update, method: :put, params: { id: @model.id, controller_model_name => attributes_for(controller_model_name, update) }

         expect(response).to redirect_to(send("admin_#{plural_controller_model_name}_path"))
        end
      end
    end
    if options[:invalid].present?
      context 'with invalid attributes' do
        it 'does not update the object' do
          process :update, method: :put, params: { id: @model.id, controller_model_name => attributes_for(controller_model_name, invalidation) }

          @model.reload

          invalidation.each do |k, v|
            expect(@model.send(k)).to_not eq(v)
          end
        end

        it 'renders the edit view' do
          process :update, method: :put, params: { id: @model.id, controller_model_name => attributes_for(controller_model_name, invalidation) }

          expect(response).to render_template(:edit)
        end
      end
    end
  end
end
