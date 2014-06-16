class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.references :group, index: true
      t.references :user, index: true
      t.string :host
      t.string :ip
      t.string :user_agent
      t.string :title
      t.text :comment

      t.timestamps
    end
  end
end
