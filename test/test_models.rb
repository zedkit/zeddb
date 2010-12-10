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
  def test_get_model
    mbss = Zedkit::Projects::Models.get(:user_key => @uu['user_key'], :project => { :uuid => @uu['projects'][0] })
    mdss = ZedDB::Models.get(:user_key => @uu['user_key'], :uuid => mbss.find{|i| i['name'] == 'bucket' }['uuid'])
    assert_equal 32, mdss['uuid'].length
    assert_equal 'bucket', mdss['name']
  end

  def test_create_model
    mdss = ZedDB::Models.create(:user_key => @uu['user_key'],
                                :project => { :uuid => @uu['projects'][0] }, :model => { :name => 'newmodel' })
    assert_equal 32, mdss['uuid'].length
    assert_equal 'newmodel', mdss['name']
  end

  def test_update_model
    mbss = Zedkit::Projects::Models.get(:user_key => @uu['user_key'], :project => { :uuid => @uu['projects'][0] })
    mduu = ZedDB::Models.update(:user_key => @uu['user_key'], :uuid => mbss[0]['uuid'], :model => { :name => 'newname' })
    assert_equal mbss[0]['uuid'], mduu['uuid']
    assert_equal 'newname', mduu['name']
  end

  def test_delete_model
    mbss = Zedkit::Projects::Models.get(:user_key => @uu['user_key'], :project => { :uuid => @uu['projects'][0] })
    mdss = ZedDB::Models.delete(:user_key => @uu['user_key'], :uuid => mbss[0]['uuid'])
    assert_equal mdss, {}
  end
end
