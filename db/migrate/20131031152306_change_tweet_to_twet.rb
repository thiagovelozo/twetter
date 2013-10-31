class ChangeTweetToTwet < ActiveRecord::Migration
  def up
    connection.execute("ALTER TABLE tweets RENAME TO twets;")
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
