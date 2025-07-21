# frozen_string_literal: true

class IssueSerializer < ActiveModel::Serializer
  attributes :number, :title, :state, :body, :created_at, :updated_at
  belongs_to :user
end
