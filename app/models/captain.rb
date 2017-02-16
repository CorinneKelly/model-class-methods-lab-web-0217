require 'pry'
class Captain < ActiveRecord::Base
  has_many :boats
  has_many :boat_classifications, through: :boats
  has_many :classifications, through: :boat_classifications

  def self.catamaran_operators
  	  joins(:classifications).where(classifications: {name: 'Catamaran'})
  end

  def self.sailors
  	joins(:classifications).where(classifications: {name: 'Sailboat'}).distinct
  end

  def self.talented_seamen
  	# new_table = self.
  	sail_id = joins(:classifications).where(classifications: {name: "Sailboat"}).pluck(:id) 
  	motor_id = joins(:classifications).where(classifications: {name: "Motorboat"}).pluck(:id)
  	# binding.pry
  	all_id = sail_id & motor_id
  	where(id: all_id)
  end

  def self.non_sailors
  	sail_boaters = joins(:classifications).where(classifications: {name: 'Sailboat'})
  	non_sailors = joins(:classifications).where.not(classifications: {name: 'Sailboat'})
  	sail_boaters.map do |cap|
  		if non_sailors.include?(cap)
  			non_sailors.delete(cap)
  		end
  	end
  	non_sailors.distinct
  end

end
