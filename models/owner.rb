require_relative("sql_runner")
require_relative("pet")

class Owner

  attr_accessor :name, :phone_number
  attr_reader :id

def initialize( options )
  @id = options['id'].to_i
  @name = options['name']
  @phone_number = options['phone_number']
end

def save()
  sql = "INSERT INTO owners
    (name,
    phone_number)
  VALUES
    ($1, $2)
  RETURNING id"
  values = [@name, @phone_number]
  results = SqlRunner.run(sql, values)
  @id = results.first()['id'].to_i
end

def update()
  sql = " UPDATE owners SET
    (name,
    phone_number)
      =
    ($1, $2)
    WHERE id = $3"
  values = [@name, @phone_number, @id]
  SqlRunner.run(sql, values)
end

def pets()
  sql = "
    SELECT * FROM pets
    WHERE owner_id = $1;"
  pet_hashes = SqlRunner.run(sql, [@id])
  pets = pet_hashes.map { |pet_hash| Pet.new(pet_hash) }
  return pets
end

def self.map_items(owner_data)
  return owner_data.map { |owner| Owner.new(owner) }
end

def self.all()
  sql = "SELECT * FROM owners;"
  owner_data = SqlRunner.run( sql, [] )
  return map_items(owner_data)
end

def delete()
  sql = "DELETE FROM owners WHERE id = $1;"
  SqlRunner.run(sql, [@id])
end

def self.delete_all()
  sql = "DELETE * FROM owners;"
  SqlRunner.run(sql, [])
end

def self.find(id)
  puts "Id #{id}"
  sql = "SELECT * FROM owners
    WHERE id = $1;"
  result = SqlRunner.run(sql, [id]).first
  puts "Result #{result}"
  owner = Owner.new(result)
  return owner
end



end
