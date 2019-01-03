class CreateImages < ActiveRecord::Migration[5.1]
  def change
    create_table :images do |t|
      t.references :product, foreign_key: true
      t.string :url
      t.timestamps
    end
  end
end
