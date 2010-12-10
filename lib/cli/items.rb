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
  module CLI
    class Items
      class << self
        def show(opts = {})
          begin
            ppii = ZedDB::ModelItems.get(:user_key => opts[:user_key], :uuid => opts[:argv][0])
            ppmm = ZedDB::Models.get(:user_key => opts[:user_key], :uuid => ppii['model']['uuid'])
            puts show_item(ppmm, ppii)
          rescue Zedkit::ZedkitError => zke
            puts zke end
        end

        def create(opts = {})
          begin
            raise Zedkit::CLI::MissingParameter.new(:message => "Model UUID is nil") if opts[:items]['model'].nil?
            ppmm = ZedDB::Models.get(:user_key => opts[:user_key], :uuid => opts[:items]['model'])
            opts[:items].delete('model')
            opts[:items]['name'] = opts[:argv][0]
            ppii = ZedDB::ModelItems.create(:user_key => opts[:user_key],
                                            :model => { :uuid => ppmm['uuid'] }, :item => opts[:items])
            puts show_item(ppmm, ppii)
          rescue Zedkit::ZedkitError => zke
            puts zke end
        end

        def update(opts = {})
          begin
            ppii = ZedDB::ModelItems.update(:user_key => opts[:user_key], :uuid => opts[:argv][0], :item => opts[:items])
            ppmm = ZedDB::Models.get(:user_key => opts[:user_key], :uuid => ppii['model']['uuid'])
            puts show_item(ppmm, ppii)
          rescue Zedkit::ZedkitError => zke
            puts zke end
        end

        def delete(opts = {})
          begin
            ppii = ZedDB::ModelItems.get(:user_key => opts[:user_key], :uuid => opts[:argv][0])
            ZedDB::ModelItems.delete(:user_key => opts[:user_key], :uuid => opts[:argv][0])
            puts "\nDONE.\nZedDB Model Data Item Removed [#{ppii['name']}].\n\n"
          rescue Zedkit::ZedkitError => zke
            puts zke end
        end

        def method_missing(*args)
          raise Zedkit::CLI::UnknownCommand.new(:message => "Unknown Command [#{args[0]}]")
        end

        protected
        def show_item(model, item)
          rs  = "\nZedDB Model Item:\n"
          rs << "  : Model         : #{model['name']}\n"
          rs << "  : UUID          : #{item['uuid']}\n"
          rs << "  : Name          : #{item['name']}\n"
          rs << "  : Type          : #{item['type']['code']}\n"
          rs << "  : Version       : #{item['version']}\n"
          rs << "  : Created       : #{Time.at(item['created_at']).to_date}\n"
          rs << "  : Updated       : #{Time.at(item['updated_at']).to_date}\n"
          rs << "---------------------\n\n"
        end
      end
    end
  end
end

