# frozen_string_literal: true
class Admin::AdministratorsController < Admin::ApplicationController
  before_action :set_administrator, only: [:edit, :update, :destroy]

  def index
    @administrators = Administrator.all
  end

  def edit; end

  def new
    @administrator = Administrator.new
  end

  def create
    @administrator = Administrator.new(administrator_params)

    if @administrator.save
      redirect_to admin_administrators_path, notice: 'Administrator was successfully created.'
    else
      flash[:error] = 'Administrator was not created.'
      render :new
    end
  end

  def update
    if @administrator.update_with_password(administrator_params)
      redirect_to admin_administrators_path, notice: 'Administrator was successfully updated.'
    else
      flash[:error] = 'Administrator was not updated.'
      render :edit
    end
  end

  def destroy
    if @administrator.destroy
      redirect_to admin_administrators_path, notice: "#{@administrator.full_name} was removed as an administrator."
    else
      flash[:error] = "Administrator was not deleted. #{@administrator.errors.full_messages.to_sentence}."
      redirect_to admin_administrators_path
    end
  end

  private

  def set_administrator
    @administrator = Administrator.find(params[:id])
  end

  def administrator_params
    params[:administrator].permit(:email, :first_name, :last_name,
                                  :remember_me, :current_password,
                                  :password, :password_confirmation)
  end
end
