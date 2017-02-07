# frozen_string_literal: true
module ModelHelper
  def model_name
    described_class.model_name.singular
  end

  def plural_model_name
    described_class.model_name.plural
  end
end

RSpec.configure do |config|
  config.include ModelHelper
end
