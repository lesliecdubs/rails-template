# frozen_string_literal: true
RSpec.shared_examples :get_success do |options|
  format = options[:format] || :html

  [options[:actions]].flatten.each do |action|
    if action.is_a?(Hash)
      action.each do |a, id|
        describe "GET #{a}" do
          it "renders #{a} view" do
            process a, method: :get, params: { id: send(id.to_s) }

            expect(response).to render_template(a) if format == :html
            expect(response).to have_http_status(:success)
          end
        end
      end
    else
      describe "GET ##{action}" do
        it "renders #{action} view" do
          process action, method: :get

          expect(response).to render_template(action) if format == :html
          expect(response).to have_http_status(:success)
        end
      end
    end
  end
end
