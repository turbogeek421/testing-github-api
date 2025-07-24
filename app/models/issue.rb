# frozen_string_literal: true

class Issue < ApplicationRecord
  belongs_to :user, optional: true

  EXPECTED_STATES = %w[open closed].freeze

  # Validation should not be enforced as this model only stores data from Github, so it should
  # be up to Github to apply validation rules. However, if validation was required...

  # validates :number, :title, presence: true
  # validates :state, inclusion: { in: EXPECTED_STATES }
end
