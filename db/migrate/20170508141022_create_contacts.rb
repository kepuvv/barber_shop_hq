class CreateContacts < ActiveRecord::Migration[5.1]
  def change
  	create_table :contacts do |t|
	  	t.text :email
	  	t.text :text
	  		
	  	t.timestamps
  	end
  end
end
