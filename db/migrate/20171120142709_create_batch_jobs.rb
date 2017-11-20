class CreateBatchJobs < ActiveRecord::Migration
  def change
    create_table :batch_jobs, primary_key: :job_id do |t|
      t.string :batch_name, null: false
      t.string :status
      t.timestamps null: false
    end
  end
end
