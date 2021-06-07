# frozen_string_literal: true

class Pet < ApplicationRecord
  validates :name, presence: true
end
