class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string  :api_key
      t.boolean :internal, null: false, default: false

      t.timestamps null: false
    end

    add_index :users, :api_key, unique: true

  end
end
