class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  private
    def assign_uuid_id
      self.id = SecureRandom.uuid
    end
end
