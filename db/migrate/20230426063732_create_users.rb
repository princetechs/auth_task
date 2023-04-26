class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.boolean :two_factor_enabled,default:true
      t.string :two_factor_token
      t.datetime :two_factor_token_sent_at

      t.timestamps
    end
  end
end
