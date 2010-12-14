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

class TestTransformers < Test::Unit::TestCase
  def test_get
    mt = ZedDB::ModelTransformers.get(:user_key => @uu['user_key'], :item => { :uuid => item_model['items'][0]['uuid'] },
                                      :uuid => item_model['items'][0]['transformers'][0]['uuid'])
    assert_equal item_model['items'][0]['uuid'], mt['item']['uuid']
    assert_equal 'DN', mt['transformer']['code']
  end
  def test_get_with_block
    ZedDB::ModelTransformers.get(:user_key => @uu['user_key'], :item => { :uuid => item_model['items'][0]['uuid'] },
                                 :uuid => item_model['items'][0]['transformers'][0]['uuid']) do |mt|
      assert_equal item_model['items'][0]['uuid'], mt['item']['uuid']
      assert_equal 'DN', mt['transformer']['code']
    end
  end

  def test_create_transformer_already_in_place
    mt = ZedDB::ModelTransformers.create(:user_key => @uu['user_key'],
                                         :item => { :uuid => pmodels.find {|i| i['name'] == 'item' }['items'][0]['uuid'] },
                                         :transformer => { :code => 'DN' })
    assert_not_nil mt
    assert_equal 'ERROR', mt['status']['result']
    assert_equal 'The model item tranformer is already in use with the model data item.',
                                                mt['errors']['attributes']['transformer']
  end
  def test_create
  end
  def test_create_with_block
  end

  def test_delete
    mt = ZedDB::ModelTransformers.delete(:user_key => @uu['user_key'], :item => { :uuid => item_model['items'][0]['uuid'] },
                                         :uuid => item_model['items'][0]['transformers'][0]['uuid'])
    assert_equal mt, {}
  end
  def test_delete_with_block
    ZedDB::ModelTransformers.delete(:user_key => @uu['user_key'], :item => { :uuid => item_model['items'][0]['uuid'] },
                                    :uuid => item_model['items'][0]['transformers'][0]['uuid']) do |mt|
      assert_equal mt, {}
    end
  end
end
