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

module ZedDB::CLI
  class << self
    def tt(locale, key, item)
      Zedkit::CLI.lookup_tt("ZedDB::CLI", locale, key, item)
    end
    def ee(locale, key, item)
      Zedkit::CLI.lookup_ee("ZedDB::CLI", locale, key, item)
    end
  end

  CONTENT = {
    :en => {
    }
  }
  ERRORS = {
    :en => {
      :model => {
        :uuid => "Model UUID is nil",
        :name => "Model name is nil"
      },
      :item => {
        :uuid => "Model Item UUID is nil",
        :name => "Model Item name is nil"
      },
      :validation => {
        :uuid => "Validation UUID is nil",
        :code => "Validation code is nil"
      },
      :transformer => {
        :uuid => "Transformer UUID is nil",
        :code => "Transformer code is nil"
      }
    }
  }.freeze
end
