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
  def test_get_model_item
    mdss = ZedDB::Models.get(:user_key => @uu['user_key'], :uuid => pmodels.find{|i| i['name'] == 'item' }['uuid'])
    miss = ZedDB::ModelItems.get(:user_key => @uu['user_key'], :uuid => mdss['items'][0]['uuid'])
    assert_equal 32, miss['uuid'].length
    assert_equal 'cool', miss['name']
    assert_equal 'SR', miss['type']['code']
  end

  def test_create_model_item
    mdss = ZedDB::Models.get(:user_key => @uu['user_key'], :uuid => pmodels.find{|i| i['name'] == 'item' }['uuid'])
    miss = ZedDB::ModelItems.create(:user_key => @uu['user_key'],
                                    :model => { :uuid => mdss['uuid'] }, :item => { :type => 'SR', :name => 'Whatever' })
    assert_equal 32, miss['uuid'].length
    assert_equal 'SR', miss['type']['code']
    assert_equal 'whatever', miss['name']
  end

  def test_update_model_item
    mdss = ZedDB::Models.get(:user_key => @uu['user_key'], :uuid => pmodels.find{|i| i['name'] == 'item' }['uuid'])
    miss = ZedDB::ModelItems.update(:user_key => @uu['user_key'],
                                    :uuid => mdss['items'][0]['uuid'], :item => { :name => 'newname' })
    assert_equal mdss['items'][0]['uuid'], miss['uuid']
    assert_equal 'newname', miss['name']
  end

  def test_delete_model_item
    mdss = ZedDB::Models.get(:user_key => @uu['user_key'], :uuid => pmodels.find{|i| i['name'] == 'item' }['uuid'])
    miss = ZedDB::ModelItems.delete(:user_key => @uu['user_key'], :uuid => mdss['items'][0]['uuid'])
    assert_equal miss, {}
  end
end
