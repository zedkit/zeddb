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

class TestAssociations < Test::Unit::TestCase
  def test_get
    ma = ZedDB::ModelAssociations.get(:user_key => @uu['user_key'],
                                      :uuid => pmodels.find {|i| i['name'] == 'bucket' }['associations'][0]['uuid'])
    assert ma.is_a? Hash
    assert_equal pmodels.find {|i| i['name'] == 'bucket' }['associations'][0]['uuid'], ma['uuid']
    assert_equal 'HM', ma['type']['code']
    assert_equal 'BT', ma['inverse']['code']
  end
  def test_get_with_block
    md = pmodels.find {|i| i['name'] == 'bucket' }
    ZedDB::ModelAssociations.get(:user_key => @uu['user_key'], :uuid => md['associations'][0]['uuid']) do |ma|
      assert ma.is_a? Hash
      assert_equal pmodels.find {|i| i['name'] == 'bucket' }['associations'][0]['uuid'], ma['uuid']
      assert_equal 'HM', ma['type']['code']
      assert_equal 'BT', ma['inverse']['code']
    end
  end

  def test_create_association_already_in_place
    ma = ZedDB::ModelAssociations.create(:user_key => @uu['user_key'],
                                         :association => { :first => pmodels.find {|i| i['name'] == 'bucket' }['uuid'],
                                                           :code => 'HM', :inverse => 'BT',
                                                           :second => pmodels.find {|i| i['name'] == 'item' }['uuid'] })
    assert_not_nil ma
    assert_equal 'ERROR', ma['status']['result']
    assert_equal "The models submitted are already associated.", ma['errors']['attributes']['association']
  end
  def test_create
  end
  def test_create_with_block
  end

  def test_delete
    ma = ZedDB::ModelAssociations.delete(:user_key => @uu['user_key'],
                                         :uuid => pmodels.find {|i| i['name'] == 'bucket' }['associations'][0]['uuid'])
    assert_equal ma, {}
  end
  def test_delete_with_block
    ZedDB::ModelAssociations.delete(:user_key => @uu['user_key'],
                                    :uuid => pmodels.find {|i| i['name'] == 'bucket' }['associations'][0]['uuid']) do |ma|
      assert_equal ma, {}
    end
  end
end
