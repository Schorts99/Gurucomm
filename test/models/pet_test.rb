# frozen_string_literal: true

require 'test_helper'

class PetTest < ActiveSupport::TestCase
  test 'should save if name is present' do
    pet = Pet.new(name: 'Test')

    assert pet.save
  end

  test 'should not save if name is not present' do
    pet = Pet.new

    assert_not pet.save
  end
end
