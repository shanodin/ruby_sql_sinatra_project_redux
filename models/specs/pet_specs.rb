require_relative('../pet.rb')
require_relative('../owner.rb')
require('pry-byebug')
require('pry')
require('minitest/autorun')

class PetTest < MiniTest::Test
  def setup
    @owner1 = Owner.new('name' => 'Alice Rees',
                        'phone_number' => '01234 567890')
    @owner1.save

    @pet1 = Pet.new('name' => 'Zeus',
                    'type' => 'Cat',
                    'breed' => 'moggie',
                    'can_adopt' => 'true',
                    'status' => 'Ready for Adoption',
                    'admission_date' => '25/08/2017')
    @pet1.save

    @pet2 = Pet.new('name' => 'Bob',
                    'type' => 'Dog',
                    'breed' => 'Labrador x Pointer',
                    'can_adopt' => 'flase',
                    'status' => 'Adopted',
                    'admission_date' => '25/08/2017',
                    'owner_id' => @owner1.id)
    @pet2.save

    @pet3 = Pet.new('name' => 'Puppy',
                    'type' => 'Exotic Animal',
                    'breed' => 'Bearded Dragon',
                    'can_adopt' => 'false',
                    'status' => 'At the Vet',
                    'admission_date' => '25/08/2017')
    @pet3.save
  end

  def test_pet_name
    assert_equal('Puppy', @pet3.name)
  end

  def test_pet_status
    assert_equal('Adopted', @pet2.status)
  end

  def test_owner_name
    owner_name = @pet2.owner.name
    assert_equal('Alice Rees', owner_name)
  end

  def test_can_adopt
    assert_equal('f', @pet3.adoptable)
  end
end
