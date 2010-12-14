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

module ZedDB
  class ModelTransformer < Zedkit::Instance
    def model_item
      ZedDB::ModelItem.new(:user_key => uk, :locale => lc, :uuid => item['uuid'])
    end

    def delete
      ZedDB::ModelTransformers.delete(:user_key => uk, :locale => lc, :item => { :uuid => item['uuid'] }, :uuid => uuid)
    end

    protected
    def set_with_owner_and_uuid(item_uuid, transformer_uuid)
      replace ZedDB::ModelTransformers.get(:user_key => uk, :locale => lc,
                                          :item => { :uuid => item_uuid }, :uuid => transformer_uuid)
    end
  end
end
