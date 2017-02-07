# frozen_string_literal: true
RSpec.shared_examples :delete_destroy do |option|
  option ||= {}

  let (:invalid_attributes) { option[:invalid_attributes] }
  let (:invalid_association) { option[:invalid_association] }

  describe 'DELETE #destroy' do
    context 'valid to destroy' do
      before do
        @model = create controller_model_name
      end

      it 'deletes the object' do
        expect{
          process :destroy, method: :delete, params: { id: @model.id }
        }.to change(controller_model, :count).by(-1)
      end

      it 'redirects back to the index' do
        process :destroy, method: :delete, params: { id: @model.id }

        expect(response).to redirect_to(send("admin_#{plural_controller_model_name}_path"))
      end
    end

    if option[:invalid_attributes].present? || option[:invalid_association].present?
      context 'not valid to destroy' do
        before do
          @model = create controller_model_name, invalid_attributes

          if invalid_association.present?
            if invalid_association[:has_many].present?
              models = invalid_association[:has_many].to_s
              count  = invalid_association[:count] || 2

              @model.send("#{models}=", create_list(models.singularize.to_sym, count))
              @model.save
            end

            if invalid_association[:has_one].present?
              model = invalid_association[:has_one]
              @model.send("#{model}=", create(model))
              @model.save
            end

            if invalid_association[:belongs_to].present?
              model = create invalid_association[:belongs_to]
              @model.send("#{invalid_association[:belongs_to]}_id=", model.id)
              @model.save
            end
          end
        end

        it 'does not destroy the object' do
          expect {
            process :destroy, method: :delete, params: { id: @model.id }
          }.to_not change(controller_model, :count)
        end

        if option[:invalid_path].present?
          it 'redirects to set path' do
            process :destroy, method: :delete, params: { id: @model.id }

            expect(response).to redirect_to(send(option[:invalid_path]))
          end
        else
          it 'redirects to index view' do
            process :destroy, method: :delete, params: { id: @model.id }

            expect(response).to redirect_to(send("admin_#{plural_controller_model_name}_path"))
          end
        end
      end
    end
  end
end
