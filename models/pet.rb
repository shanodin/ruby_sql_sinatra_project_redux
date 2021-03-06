require_relative('sql_runner')
require_relative('owner')

class Pet
  attr_accessor :name, :type, :breed, :can_adopt, :status, :owner_id, :photo
  attr_reader :id, :admission_date

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @type = options['type']
    @breed = options['breed']
    @can_adopt = options['can_adopt']
    @status = options['status']
    @admission_date = options['admission_date']
    if options['owner_id'] && options['owner_id'] != ''
      @owner_id = options['owner_id'].to_i
    end
    @photo = options['photo']
    if @owner_id
      @status = 'Adopted'
      @can_adopt = 'f'
    end
  end

  def save
    sql = "INSERT INTO pets
      (name,
      type,
      breed,
      can_adopt,
      status,
      owner_id,
      photo)
    VALUES
      ($1, $2, $3, $4, $5, $6, $7)
    RETURNING *;"
    values = [@name, @type, @breed, @can_adopt, @status, @owner_id, @photo]
    results = SqlRunner.run(sql, values)
    @id = results.first['id'].to_i
  end

  def update
    sql = "UPDATE pets SET
      (name,
      type,
      breed,
      can_adopt,
      status,
      owner_id,
      photo)
        =
      ($1, $2, $3, $4, $5, $6, $7)
    WHERE id = $8"
    values = [@name, @type, @breed, @can_adopt, @status, @owner_id, @photo, @id]
    SqlRunner.run(sql, values)
  end

  def self.map_items(pet_data)
    pet_data.map { |pet| Pet.new(pet) }
  end

  def self.all
    sql = 'SELECT * FROM pets ORDER BY admission_date;'
    pet_data = SqlRunner.run(sql, [])
    map_items(pet_data)
  end

  def delete
    sql = 'DELETE FROM pets WHERE id = $1;'
    SqlRunner.run(sql, [@id])
  end

  def self.delete_all
    sql = 'DELETE * FROM pets;'
    SqlRunner.run(sql, [])
  end

  def self.find(id)
    sql = 'SELECT * FROM pets WHERE id = $1;'
    pet = SqlRunner.run(sql, [id])
    result = Pet.new(pet.first)
    result
  end

  def owner
    sql = "
      SELECT * FROM owners WHERE id = $1;"
    results = SqlRunner.run(sql, [@owner_id])
    hash = results[0]
    owner = Owner.new(hash)
    owner
  end

  def self.adoptable
    sql = "SELECT * FROM pets WHERE status = 'Ready for Adoption';"
    results = SqlRunner.run(sql, [])
    map_items(results)
  end

  def self.find_by_type(type)
    sql = 'SELECT * FROM pets WHERE type = $1;'
    results = SqlRunner.run(sql, [type])
    map_items(results)
  end
end
