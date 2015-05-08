class CreatePolicySymbols < ActiveRecord::Migration
  def change
    create_table :policy_symbols do |t|
      t.text :code

      t.timestamps
    end
  end
end
