require 'test_helper'

class CompanyTest < ActiveSupport::TestCase
  def setup
    @company = companies(:hometown_painting)
  end

  test 'email should belong @getmainstreet domain' do
    @company.email = 'ameed@ameed.com'
    @company.save
    assert_equal @company.errors.messages[:email], [": Please enter a valid 'getmainstreet' email id"]

    @company.email = 'ameed@getmainstreet.com'
    assert @company.save
  end

  test 'allow blank email' do
    @company.email = nil
    assert @company.save
  end

  test 'zip code should be correct' do
    @company.zip_code = 'qwe'
    @company.save
    assert_equal @company.errors.messages[:zip_code], [': Please enter a valid US zip code']

    @company.zip_code = ''
    @company.save
    assert_equal @company.errors.messages[:zip_code], ["can't be blank", ': Please enter a valid US zip code']

    @company.zip_code = '93003'
    assert @company.save
  end
end