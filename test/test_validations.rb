##
# Copyright (c) Zedkit.
#
# Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation
# files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy,
# modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the
# Software is furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all copies or substantial portions of the
# Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
# WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
# COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
# ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
##

require 'helper'

class TestValidations < Test::Unit::TestCase
  def test_get
    mv = ZedDB::ModelValidations.get(:user_key => @uu['user_key'], :item => { :uuid => item_model['items'][0]['uuid'] },
                                     :uuid => item_model['items'][0]['validations'][0]['uuid'])
    assert_equal item_model['items'][0]['uuid'], mv['item']['uuid']
    assert_equal 'SB', mv['validation']['code']
  end
  def test_get_with_block
    ZedDB::ModelValidations.get(:user_key => @uu['user_key'], :item => { :uuid => item_model['items'][0]['uuid'] },
                                :uuid => item_model['items'][0]['validations'][0]['uuid']) do |mv|
      assert_equal item_model['items'][0]['uuid'], mv['item']['uuid']
      assert_equal 'SB', mv['validation']['code']
    end
  end

  def test_create_model_validation_already_in_place
    mv = ZedDB::ModelValidations.create(:user_key => @uu['user_key'], :item => { :uuid => item_model['items'][0]['uuid'] },
                                        :validation => { :code => 'SB' })
    assert_not_nil mv
    assert_equal 'ERROR', mv['status']['result']
    assert_equal 'The model item validation is already in use with the model data item.',
                                               mv['errors']['attributes']['validation']
  end
  def test_create
  end
  def test_create_with_block
  end

  def test_update
    mv = ZedDB::ModelValidations.update(:user_key => @uu['user_key'], :item => { :uuid => item_model['items'][0]['uuid'] },
                                        :uuid => item_model['items'][0]['validations'][0]['uuid'],
                                        :validation => { :qualifier => 'stuff' })
    assert_equal 'stuff', mv['qualifier']
  end
  def test_update_with_block
    ZedDB::ModelValidations.update(:user_key => @uu['user_key'], :item => { :uuid => item_model['items'][0]['uuid'] },
                                        :uuid => item_model['items'][0]['validations'][0]['uuid'],
                                        :validation => { :qualifier => 'stuff' }) do |mv|
      assert_equal 'stuff', mv['qualifier']
    end
  end

  def test_delete
    mv = ZedDB::ModelValidations.delete(:user_key => @uu['user_key'], :item => { :uuid => item_model['items'][0]['uuid'] },
                                        :uuid => item_model['items'][0]['validations'][0]['uuid'])
    assert_nil mv
  end
  def test_delete_with_block
    ZedDB::ModelValidations.delete(:user_key => @uu['user_key'], :item => { :uuid => item_model['items'][0]['uuid'] },
                                   :uuid => item_model['items'][0]['validations'][0]['uuid']) do |mv|
      assert_nil mv
    end
  end
end
