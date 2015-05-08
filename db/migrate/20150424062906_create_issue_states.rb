class CreateIssueStates < ActiveRecord::Migration
  def change
    create_table :issue_states do |t|
      t.integer :state_id
      t.string :state_code

      t.timestamps
    end
  end
end
