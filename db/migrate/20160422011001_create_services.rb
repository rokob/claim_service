class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.integer  :claim_id, null: false
      t.string   :code
      t.float    :cost
      t.datetime :date

      t.timestamps null: false
    end

    add_index :services, :claim_id

  end
end
