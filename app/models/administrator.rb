# frozen_string_literal: true
# == Schema Information
#
# Table name: administrators
#
#  id                     :integer          not null, primary key
#  first_name             :string
#  last_name              :string
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_administrators_on_confirmation_token    (confirmation_token) UNIQUE
#  index_administrators_on_email                 (email) UNIQUE
#  index_administrators_on_reset_password_token  (reset_password_token) UNIQUE
#

class Administrator < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :timeoutable

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true

  before_destroy :at_least_one

  def full_name
    "#{first_name} #{last_name}"
  end

  private

  def at_least_one
    if Administrator.all.length < 2
      errors[:base] << 'There must be at least one administrator'
      return false
    end
  end
end
