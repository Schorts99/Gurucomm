# frozen_string_literal: true

# Pagination utils
module Pagination
  extend ActiveSupport::Concern

  def validate_pagination_params
    validate_limit_param
    validate_page_param
  end

  def elements_to_skip(page, limit)
    (page > 1 ? page - 1 : 0) * limit
  end

  private

  def validate_limit_param
    return if params[:limit].blank?

    limit = params[:limit].to_i
    return if limit.positive? && limit <= 100

    error = Error.new(code: 'INVALID_LIMIT', message: I18n.t('pets.index.invalid_limit_type'))
    render json: error, status: :bad_request
  end

  def validate_page_param
    return if params[:page].blank?

    page = params[:page].to_i
    return if page.is_a?(Integer) && page.positive?

    error = Error.new(code: 'INVALID_PAGE', message: I18n.t('pets.index.invalid_page_type'))
    render json: error, status: :bad_request
  end
end
