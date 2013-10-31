class CreateRetweets < ActiveRecord::Migration
  def change
    create_table :retweets do |t|
      t.integer :tweet_id
      t.integer :user_id

      t.timestamps
    end

    add_index :retweets, [:tweet_id, :user_id]
  end
end
