# frozen_string_literal: true

# Модель Пользователя
class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: true
end
