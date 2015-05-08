class CreatePolicyStatuses < ActiveRecord::Migration
  def change
    create_table :policy_statuses do |t|
      t.text :status

      t.timestamps
    end
  end
end
