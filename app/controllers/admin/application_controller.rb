# frozen_string_literal: true
class Admin::ApplicationController < ApplicationController
  layout 'admin/application'

  before_action :authenticate_administrator!

  add_flash_types :success, :error

  def index; end

end
