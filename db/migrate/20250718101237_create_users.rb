# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users, id: :string do |t|
      t.string :login
      t.string :avatar_url
      t.string :type
      t.string :url
      t.timestamps
    end
  end
end
