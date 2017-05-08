class CreateBarbers < ActiveRecord::Migration[5.1]
  def change
  	create_table :barbers do |t|
  		t.text :name
  		
  		t.timestamps
  	end

  	Barber.create :name => 'Jessie Pinkman'
  	Barber.create :name => 'Gus'
  	Barber.create :name => 'Walter White'

  end
end
