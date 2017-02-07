# frozen_string_literal: true
RSpec.shared_examples :get_show do
  let (:model_traits) { options[:model_traits] || [] }

  describe 'GET #show' do
    before do
      @model = create controller_model_name, *model_traits
    end

    it 'renders show view' do
      process :show, method: :get, params: { id: @model.id }

      expect(response).to render_template(:show)
      expect(response).to have_http_status(:success)
    end

    it 'loads the right object' do
      process :show, method: :get, params: { id: @model.id }

      expect(assigns(controller_model_name)).to eq(@model)
    end
  end
end
