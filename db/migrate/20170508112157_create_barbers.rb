class CreateBarbers < ActiveRecord::Migration[5.1]
  def change
  	create_table :barber do |t|
  		t.text :name
  		
  		t.timestamps
  	end

  	Berber.create :name => 'Jessie Pinkman'
  	Berber.create :name => 'Gus'
  	Berber.create :name => 'Walter White'

  end
end
