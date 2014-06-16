class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.references :group, index: true
      t.string :name
      t.string :email

      t.timestamps
    end
  end
end
