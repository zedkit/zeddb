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

class TestModelItems < Test::Unit::TestCase
  def test_get
    md = ZedDB::Models.get(:user_key => @uu['user_key'], :uuid => pmodels.find {|i| i['name'] == 'item' }['uuid'])
    mi = ZedDB::ModelItems.get(:user_key => @uu['user_key'], :uuid => md['items'][0]['uuid'])
    assert_equal 32, mi['uuid'].length
    assert_equal 'cool', mi['name']
    assert_equal 'STRING', mi['type']['code']
  end
  def test_get_with_block
    md = ZedDB::Models.get(:user_key => @uu['user_key'], :uuid => pmodels.find {|i| i['name'] == 'item' }['uuid'])
    ZedDB::ModelItems.get(:user_key => @uu['user_key'], :uuid => md['items'][0]['uuid']) do |mi|
      assert_equal 32, mi['uuid'].length
      assert_equal 'cool', mi['name']
    end
  end

  def test_create
    md = ZedDB::Models.get(:user_key => @uu['user_key'], :uuid => pmodels.find {|i| i['name'] == 'item' }['uuid'])
    mi = ZedDB::ModelItems.create(:user_key => @uu['user_key'],
                                  :model => { :uuid => md['uuid'] }, :item => { :type => 'STRING', :name => 'Whatever' })
    assert_equal 32, mi['uuid'].length
    assert_equal 'whatever', mi['name']
    assert_equal 'STRING', mi['type']['code']
  end
  def test_create_with_block
    md = ZedDB::Models.get(:user_key => @uu['user_key'], :uuid => pmodels.find {|i| i['name'] == 'item' }['uuid'])
    ZedDB::ModelItems.create(:user_key => @uu['user_key'],
                             :model => { :uuid => md['uuid'] }, :item => { :type => 'STRING', :name => 'Whatever' }) do |mi|
      assert_equal 32, mi['uuid'].length
      assert_equal 'whatever', mi['name']
    end
  end

  def test_update
    md = ZedDB::Models.get(:user_key => @uu['user_key'], :uuid => pmodels.find {|i| i['name'] == 'item' }['uuid'])
    mi = ZedDB::ModelItems.update(:user_key => @uu['user_key'],
                                  :uuid => md['items'][0]['uuid'], :item => { :name => 'newname' })
    assert_equal md['items'][0]['uuid'], mi['uuid']
    assert_equal 'newname', mi['name']
  end
  def test_update_with_block
    md = ZedDB::Models.get(:user_key => @uu['user_key'], :uuid => pmodels.find {|i| i['name'] == 'item' }['uuid'])
    ZedDB::ModelItems.update(:user_key => @uu['user_key'],
                             :uuid => md['items'][0]['uuid'], :item => { :name => 'newname' }) do |mi|
      assert_equal md['items'][0]['uuid'], mi['uuid']
    end
  end

  def test_delete
    md = ZedDB::Models.get(:user_key => @uu['user_key'], :uuid => pmodels.find {|i| i['name'] == 'item' }['uuid'])
    mi = ZedDB::ModelItems.delete(:user_key => @uu['user_key'], :uuid => md['items'][0]['uuid'])
    assert_nil mi
  end
  def test_delete_with_block
    md = ZedDB::Models.get(:user_key => @uu['user_key'], :uuid => pmodels.find {|i| i['name'] == 'item' }['uuid'])
    ZedDB::ModelItems.delete(:user_key => @uu['user_key'], :uuid => md['items'][0]['uuid']) do |mi|
      assert_nil mi
    end
  end
end
