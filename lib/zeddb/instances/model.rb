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
  class Model < Zedkit::Instance
    def project
      Zedkit::Project.new(:user_key => uk, :locale => lc, :uuid => self['project']['uuid'])
    end

    def associations
      self.has_key?('associations') && self['associations'].is_a?(Array) ? self['associations'] : []
    end
    def items
      self.has_key?('items') && self['items'].is_a?(Array) ? self['items'] : []
    end

    def update
    end
    def delete
      ZedDB::Models.delete(:user_key => uk, :locale => lc, :uuid => uuid)
    end

    def to_s
      rs  = "\nZedDB Model within Project '#{project['name']}':\n" \
         << "  Name           : #{self['name']}\n" \
         << "  UUID           : #{self['uuid']}\n" \
         << "  Resource       : #{self['plural_name']}\n" \
         << "  Class          : #{self['model_name']}\n" \
         << "  Associations   : #{associations.count}\n" \
         << "  Data Items     : #{items.count}\n" \
         << "  Locations      : #{self['locations'][0]}\n" \
         << "                   #{self['locations'][1]}\n" \
         << "  Version        : #{self['version']}\n" \
         << "  Created        : #{Time.at(self['created_at']).to_date}\n" \
         << "  Updated        : #{Time.at(self['updated_at']).to_date}\n"
      if items.empty?
        rs << dashes(20)
      else
        rs << dashes(122) << "| #{'Data Items'.ljust(118)} |\n" << dashes(122) \
           << "| #{'UUID'.ljust(32)} | #{'Name'.ljust(32)} | #{'Type'.ljust(12)} | #{'Validations'.center(15)} " \
           << "| #{'Transformers'.center(15)} |\n" << dashes(122)
        items.each do |mi|
          rs << "| #{mi['uuid']} | #{mi['name'].ljust(32)} | #{mi['type']['code'].ljust(12)} " \
             << "| #{mi['validations'].length.to_s.center(15)} | #{mi['transformers'].length.to_s.center(15)} |\n"
        end
        rs <<  dashes(122)
      end
      rs << "\n"
    end

    protected
    def set_with_uuid(uuid_to_use)
      replace ZedDB::Models.get(:user_key => uk, :locale => lc, :uuid => uuid_to_use)
    end
  end
end

