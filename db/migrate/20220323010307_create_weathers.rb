class CreateWeathers < ActiveRecord::Migration[6.1]
  def change
    create_table :weathers do |t|
      t.string :precipitation
      t.string :wind
      t.string :time

      t.timestamps
    end
  end
end
