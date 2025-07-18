# frozen_string_literal: true

class Issue < ApplicationRecord
  before_create :assign_uuid_id

  belongs_to :user, optional: true
end
