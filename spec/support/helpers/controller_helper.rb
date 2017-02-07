# frozen_string_literal: true
module ControllerHelper
  def controller_model
    described_class.controller_name.classify.constantize
  end

  def plural_controller_model_name
    controller_model.model_name.plural
  end

  def controller_model_name
    controller_model.model_name.singular
  end
end

RSpec.configure do |config|
  config.include ControllerHelper
end
