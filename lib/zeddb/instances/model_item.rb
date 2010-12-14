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
  class ModelItem < Zedkit::Instance
    def model
      ZedDB::Model.new(:user_key => uk, :locale => lc, :uuid => self['model']['uuid'])
    end

    def validations
      self.has_key?('validations') && self['validations'].is_a?(Array) ? self['validations'] : []
    end
    def transformers
      self.has_key?('transformers') && self['transformers'].is_a?(Array) ? self['transformers'] : []
    end
    
    def update
    end
    def delete
      ZedDB::ModelItems.delete(:user_key => uk, :locale => lc, :uuid => uuid)
    end
    
    def to_s
      rs  = "\nZedDB Data Item within Model \"#{model['name']}\":\n" \
         << "  Name           : #{self['name']}\n" \
         << "  UUID           : #{self['uuid']}\n" \
         << "  Type           : #{self['type']['code']}\n" \
         << "  Validations    : #{validations.count}\n" \
         << "  Transformers   : #{transformers.count}\n" \
         << "  Version        : #{self['version']}\n" \
         << "  Created        : #{time(self['created_at'])}\n" \
         << "  Updated        : #{time(self['updated_at'])}\n"
      if validations.empty? && transformers.empty?
        rs << dashes(20) << "\n"
      else
        unless validations.empty?
          rs << dashes(70) << "| #{'Data Item Validations'.center(66)} |\n" << dashes(70) \
             << "| #{'UUID'.ljust(32)} | #{'Code'.center(4)} | #{'Qualifier'.center(24)} |\n" << dashes(70)
          validations.each {|vd| rs << "| #{vd['uuid']} | #{vd['validation']['code'].center(4)} | #{qualifier(vd)} |\n" }
          rs << dashes(70)
        end
        unless transformers.empty?
          rs << dashes(70) << "| #{'Data Item Transformers'.center(66)} |\n" << dashes(70) \
             << "| #{'UUID'.ljust(32)} | #{'Code'.center(31)} |\n" << dashes(70)
          transformers.each {|ts| rs << "| #{ts['uuid']} | #{ts['transformer']['code'].center(31)} |\n" }
          rs << dashes(70)
        end
        rs << "\n"
      end
      rs
    end

    protected
    def set_with_uuid(uuid_to_use)
      replace ZedDB::ModelItems.get(:user_key => uk, :locale => lc, :uuid => uuid_to_use)
    end

    private
    def qualifier(vd)
      vd.has_key?('qualifier') ? vd['qualifer'].center(24) : 'N/A'.center(24)
    end
  end
end
