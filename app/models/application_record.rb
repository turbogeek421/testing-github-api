class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  before_create :assign_uuid_id

  private
    def assign_uuid_id
      self.id = SecureRandom.uuid
    end
end
