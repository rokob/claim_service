class CreateSubmissions < ActiveRecord::Migration
  def change
    create_table :submissions do |t|
      t.integer :insured_id, null: false
      t.integer :provider_id, null: false
      t.integer :claim_id
      t.text    :services

      t.timestamps null: false
    end

    add_index :submissions, :insured_id
    add_index :submissions, :provider_id

  end
end
