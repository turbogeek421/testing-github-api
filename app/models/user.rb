# frozen_string_literal: true

class User < ApplicationRecord
  before_create :assign_uuid_id

  has_many :issues

  # Validation should not be enforced as this model only stores data from Github, so it should
  # be up to Github to apply validation rules. However, if validation was required...

  # EXPECTED_TYPES = %w[User Admin].freeze

  # validates :login, presence: true
  # validates :type, inclusion: { in: EXPECTED_TYPES }
  # validates :avatar_url, :url,
  #           format: {
  #             with: URI::DEFAULT_PARSER.make_regexp(%w[http https]),
  #             message: "must be a valid URL"
  #           },
  #           allow_blank: true
end
