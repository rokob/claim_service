class CreateSubmissions < ActiveRecord::Migration
  def change
    create_table :submissions do |t|
      t.integer :insured_id, null: false
      t.integer :provider_id, null: false
      t.integer :claim_id
      t.text    :services

      t.timestamps null: false
    end
  end
end
