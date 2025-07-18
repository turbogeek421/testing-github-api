# frozen_string_literal: true

class User < ApplicationRecord
  before_create :assign_uuid_id
end
