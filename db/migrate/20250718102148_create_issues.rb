# frozen_string_literal: true

class CreateIssues < ActiveRecord::Migration[7.1]
  def change
    create_table :issues, id: :string do |t|
      t.integer :number
      t.string :title
      t.string :state
      t.text :body
      t.string :user_id
      t.timestamps
    end
  end
end
