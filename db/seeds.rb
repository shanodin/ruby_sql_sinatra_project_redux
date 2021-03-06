require_relative('../models/owner.rb')
require_relative('../models/pet.rb')
require('pry-byebug')

owner1 = Owner.new('name' => 'Matthew Addison',
                   'phone_number' => '01234567890')
owner1.save

owner2 = Owner.new('name' => 'Alice Rees',
                   'phone_number' => '01987654321')
owner2.save

owner3 = Owner.new('name' => 'Seamus Macleod',
                   'phone_number' => '04820475262')
owner3.save

owner4 = Owner.new('name' => 'Jonny Lockhart',
                   'phone_number' => '03966484659')
owner4.save

pet1 = Pet.new('name' => 'Zeus',
               'type' => 'Cat',
               'breed' => 'moggie',
               'can_adopt' => 'true',
               'status' => 'Ready for Adoption',
               'photo' => 'zeus.jpg')
pet1.save

pet2 = Pet.new('name' => 'Reilly',
               'type' => 'Dog',
               'breed' => 'Spaniel',
               'can_adopt' => 'false',
               'status' => 'Adopted',
               'owner_id' => owner1.id,
               'photo' => 'reilly.jpg')
pet2.save

pet3 = Pet.new('name' => 'Puppy',
               'type' => 'Exotic Animal',
               'breed' => 'Bearded Dragon',
               'can_adopt' => 'false',
               'status' => 'At the Vet',
               'photo' => 'puppy.jpg')
pet3.save

pet4 = Pet.new('name' => 'Sinclair',
               'type' => 'Cat',
               'breed' => 'Rag Doll',
               'can_adopt' => 'true',
               'status' => 'Ready for Adoption',
               'photo' => 'sinclair.jpg')
pet4.save
