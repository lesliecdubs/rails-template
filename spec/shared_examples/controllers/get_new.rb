# frozen_string_literal: true
RSpec.shared_examples :get_new do
  describe 'GET #new' do
    it 'renders new view' do
      process :new, method: :get

      expect(response).to render_template(:new)
      expect(response).to have_http_status(:success)
    end
  end
end
