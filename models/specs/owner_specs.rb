require_relative( '../owner.rb' )
require('pry-byebug')
require("pry")
require('minitest/autorun')

class OwnerTest < MiniTest::Test

  def setup

    @owner1 = Owner.new({
      'name' => 'Matthew Addison',
      'phone_number' => '01234 567890'
      })
    @owner1.save()

    @owner2 = Owner.new({
      'name' => 'Alice Rees',
      'phone_number' => '01987 654321'
      })
    @owner2.save()

  end

  def test_owner_name
    assert_equal('Alice Rees', @owner2.name)
  end

  def test_owner_phone_number
    assert_equal('01234 567890', @owner1.phone_number)
  end

end
