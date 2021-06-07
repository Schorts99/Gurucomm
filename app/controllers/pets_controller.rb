# frozen_string_literal: true

# Pets resource actions
class PetsController < ApplicationController
  include Pagination

  before_action :validate_pagination_params, only: :index
  before_action :validate_create_params, only: :create

  def index
    pets = Pet.all.limit(limit_param).offset(elements_to_skip(page_param, limit_param))
    response.headers['x-next'] = "#{request.base_url}#{pets_path}?page=#{page_param + 1}"
    render json: pets
  end

  def create
    pet = Pet.new(pet_params)

    return render json: nil, status: :created if pet.save

    error = Error.new(code: 'CANT_CREATE_PET', message: pett.errors.full_messages)
    render json: error, status: :internal_server_error
  end

  def show
    begin
      pet = Pet.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      return render json: Error.new(code: 'PET_NOT_FOUND', message: I18n.t('pets.show.not_found')),
                    status: :not_found
    end

    render json: pet
  end

  private

  def pet_params
    params.permit(:name, :tag)
  end

  def limit_param
    params[:limit] ? params[:limit].to_i : 20
  end

  def page_param
    params[:page] ? params[:page].to_i : 1
  end

  def validate_create_params
    name = params[:name]

    return if name.present?

    render json: Error.new(code: 'INVALID_LIMIT', message: I18n.t('pets.create.name_must_be_present')),
           status: :bad_request
  end
end
