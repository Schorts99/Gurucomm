# frozen_string_literal: true

require 'test_helper'

class PetsControllerTest < ActionDispatch::IntegrationTest
  test 'index action should success with no params' do
    get pets_path

    assert_response :success
    assert_equal Pet.all.limit(20).to_json, @response.parsed_body.to_json
    assert_equal @response.headers['x-next'], "#{request.base_url}#{pets_path}?page=2"
  end

  test 'index action should return a limit of n elements' do
    get pets_path, params: { limit: 1 }

    assert_response :success
    assert_equal Pet.all.limit(1).to_json, @response.parsed_body.to_json
  end

  test 'index action should skip a limit of n elements' do
    get pets_path, params: { limit: 1, page: 2 }

    assert_response :success
    assert_equal Pet.all.limit(1).offset(1).to_json, @response.parsed_body.to_json
  end

  test 'create action should success' do
    assert_difference -> { Pet.count }, 1 do
      post pets_path, params: { name: 'Test' }
    end

    assert_response :created
    assert_equal Pet.last.name, 'Test'
  end

  test 'create action requires a name' do
    assert_no_difference -> { Pet.count } do
      post pets_path
    end

    assert_response :bad_request
  end

  test 'show action returns requested pet' do
    requested_pet = pets(:test)

    get pet_path(requested_pet.id)

    assert_equal requested_pet.to_json, @response.parsed_body.to_json
  end
end
