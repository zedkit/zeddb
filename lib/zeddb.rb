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

require 'rubygems'
require 'zedkit'

module ZedDB
  class << self
    def entities
      rs = Zedkit::Client.get('entities/zeddb')
      if rs && block_given?
        rs.is_a?(Array) ? rs.each {|i| yield(i) } : yield(rs)
      end
      rs
    end
  end
end

require 'zeddb/instances/model.rb'
require 'zeddb/instances/model_item.rb'
require 'zeddb/instances/model_transformer.rb'
require 'zeddb/instances/model_validation.rb'
require 'zeddb/instances/project.rb'

require 'zeddb/resources/models.rb'
require 'zeddb/resources/model_associations.rb'
require 'zeddb/resources/model_items.rb'
require 'zeddb/resources/model_transformers.rb'
require 'zeddb/resources/model_validations.rb'
require 'zeddb/resources/projects.rb'
