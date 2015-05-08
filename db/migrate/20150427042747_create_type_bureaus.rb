class CreateTypeBureaus < ActiveRecord::Migration
  def change
    create_table :type_bureaus do |t|
      t.string :code

      t.timestamps
    end
  end
end
