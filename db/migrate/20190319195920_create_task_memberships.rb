class CreateTaskMemberships < ActiveRecord::Migration[5.2]
  def change
    create_table :task_memberships do |t|
      t.references :task
      t.references :standup, foreign_key: true
    end
  end
end
