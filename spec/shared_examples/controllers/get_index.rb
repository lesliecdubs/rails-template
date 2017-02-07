# frozen_string_literal: true
RSpec.shared_examples :get_index do
  describe 'GET #index' do
    it 'loads the index view' do
      process :index, method: :get

      expect(response).to render_template(:index)
    end

    it 'loads successfully with an http 200 status code' do
      process :index, method: :get

      expect(response).to have_http_status(:success)
    end

    it "populates an array of objects" do
      models = create_list(controller_model_name, 3)
      process :index, method: :get
      expect(assigns(plural_controller_model_name)).to match_array(models)
    end
  end
end
