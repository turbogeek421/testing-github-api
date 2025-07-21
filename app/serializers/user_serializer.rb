# frozen_string_literal: true

class UserSerializer < ActiveModel::Serializer
  attributes :login, :avatar_url, :type, :url
end
