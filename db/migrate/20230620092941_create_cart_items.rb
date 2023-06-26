class CreateCartItems < ActiveRecord::Migration[6.1]
  def change
    create_table :cart_items do |t|
      t.integer    :custmer_id, null: false
      t.integer    :product_id, null: false
      t.integer    :quantity, null: false
      t.timestamps
    end
  end
end
