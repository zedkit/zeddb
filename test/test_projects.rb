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

class TestProjects < Test::Unit::TestCase
  def test_get_models
    ms = Zedkit::Projects::Models.get(:user_key => @uu['user_key'], :project => { :uuid => @uu['projects'][0] })
    assert_equal 3, ms.length
    assert ms[0].member? 'name'
    assert ms[0].member? 'uuid'
    assert ms[1].member? 'name'
    assert ms[1].member? 'uuid'
  end
  def test_get_models_with_block
    Zedkit::Projects::Models.get(:user_key => @uu['user_key'], :project => { :uuid => @uu['projects'][0] }) do |ms|
      assert ms.member? 'name'
      assert ms.member? 'uuid'
    end
  end
end
