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

class TestModels < Test::Unit::TestCase
  def test_get
    md = ZedDB::Models.get(:user_key => @uu['user_key'], :uuid => pmodels.find {|i| i['name'] == 'bucket' }['uuid'])
    assert_equal 32, md['uuid'].length
    assert_equal 'bucket', md['name']
  end
  def test_get_with_block
    ZedDB::Models.get(:user_key => @uu['user_key'], :uuid => pmodels.find {|i| i['name'] == 'bucket' }['uuid']) do |md|
      assert_equal 32, md['uuid'].length
      assert_equal 'bucket', md['name']
    end
  end

  def test_create
    md = ZedDB::Models.create(:user_key => @uu['user_key'],
                              :project => { :uuid => @uu['projects'][0] }, :model => { :name => 'newmodel' })
    assert_equal 32, md['uuid'].length
    assert_equal 'newmodel', md['name']
  end
  def test_create_with_block
    ZedDB::Models.create(:user_key => @uu['user_key'],
                         :project => { :uuid => @uu['projects'][0] }, :model => { :name => 'newmodel' }) do |md|
      assert_equal 32, md['uuid'].length
      assert_equal 'newmodel', md['name']
    end
  end

  def test_update
    ms = pmodels
    md = ZedDB::Models.update(:user_key => @uu['user_key'], :uuid => ms.find {|m| m['name'] == 'bucket' }['uuid'],
                              :model => { :name => 'newname' })
    assert_equal ms.find {|m| m['name'] == 'bucket' }['uuid'], md['uuid']
    assert_equal 'newname', md['name']
  end
  def test_update_with_block
    ms = pmodels
    ZedDB::Models.update(:user_key => @uu['user_key'], :uuid => ms.find {|m| m['name'] == 'bucket' }['uuid'],
                         :model => { :name => 'newname' }) do |md|
      assert_equal ms.find {|m| m['name'] == 'bucket' }['uuid'], md['uuid']
      assert_equal 'newname', md['name']
    end
  end

  def test_delete
    md = ZedDB::Models.delete(:user_key => @uu['user_key'], :uuid => pmodels.find {|m| m['name'] == 'bucket' }['uuid'])
    assert_nil md
  end
  def test_delete_with_block
    ZedDB::Models.delete(:user_key => @uu['user_key'], :uuid => pmodels.find {|m| m['name'] == 'bucket' }['uuid']) do |md|
      assert_nil md
    end
  end
end
