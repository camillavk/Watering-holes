class AddUserIdToRestaurant < ActiveRecord::Migration
  def change
    add_reference :restaurants, :user, index: true
  end
end
