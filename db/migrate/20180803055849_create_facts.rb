class CreateFacts < ActiveRecord::Migration
  def change
    create_table :facts do |t|
      t.string :content
      t.integer :user_id
    end
  end
end
