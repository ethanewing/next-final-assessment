class ChangeFollowerIdInRelationships < ActiveRecord::Migration[5.1]
  def change
    change_table :relationships do |t|
      t.remove :follower_id
      t.belongs_to :user, index: true
    end
  end
end
