# frozen_string_literal: true
RSpec.shared_examples :get_edit do |options|
  let (:model_traits) do
    if options.present?
      options[:model_traits] || []
    else
      []
    end
  end

  describe 'GET #edit' do
    before do
      @model = create controller_model_name, *model_traits
    end

    it 'renders edit view' do
      process :edit, method: :get, params: { id: @model.id }

      expect(response).to render_template(:edit)
      expect(response).to have_http_status(:success)
    end

    it 'loads the right object' do
      process :edit, method: :get, params: { id: @model.id }

      expect(assigns(controller_model_name)).to eq(@model)
    end
  end
end
