class CreateVarieties < ActiveRecord::Migration[5.2]
  def change
    create_table :varieties do |t|
      t.belongs_to :plot, index: true, foreign_key: true
      t.belongs_to :plant, index: true, foreign_key: true
    end
  end
end
