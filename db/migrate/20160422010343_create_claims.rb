class CreateClaims < ActiveRecord::Migration
  def change
    create_table :claims do |t|
      t.integer :insured_id, null: false
      t.integer :provider_id, null: false
      t.integer :status, null: false, default: 0

      t.timestamps null: false
    end

    add_index :claims, :insured_id
    add_index :claims, :provider_id

  end
end
