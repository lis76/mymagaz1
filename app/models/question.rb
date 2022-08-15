# frozen_string_literal: true

# This shiny device polishes bared Questions
class Question < ApplicationRecord
  has_many :answers, dependent: :destroy
  validates :title, presence: true, length: { minimum: 3 }
  validates :body, presence: true, length: { minimum: 3 }
end
