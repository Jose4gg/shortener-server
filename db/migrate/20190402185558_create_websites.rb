class CreateWebsites < ActiveRecord::Migration[5.2]
  def change
    create_table :websites do |t|
      t.string :url, null: false
      t.string :short_id, null: true
      t.boolean :processing_title, default: true
      t.integer :visited_count, default: 0
      t.timestamps null: false
    end

    add_index :websites, :url, unique: true
    # add_index :websites, :short_id, unique: true
  end
end
