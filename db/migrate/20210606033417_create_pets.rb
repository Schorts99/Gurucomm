# frozen_string_literal: true

# Create pets table
class CreatePets < ActiveRecord::Migration[6.1]
  def change
    create_table :pets do |t| # rubocop:disable Rails/CreateTableWithTimestamps
      t.string :name, null: false
      t.string :tag
    end
  end
end
