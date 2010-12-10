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
    class Models
      class << self
        def show(opts = {})
          begin
            ppmm = ZedDB::Models.get(:user_key => opts[:user_key], :uuid => opts[:argv][0])
            ppss = Zedkit::Projects.get(:user_key => opts[:user_key], :uuid => ppmm['project']['uuid'])
            puts show_model(ppss, ppmm)
          rescue Zedkit::ZedkitError => zke
            puts zke end
        end

        def create(opts = {})
          begin
            ppss = Zedkit::Projects.get(:user_key => opts[:user_key], :uuid => opts[:items]['project'])
            opts[:items].delete('project')
            opts[:items]['name'] = opts[:argv][0]
            ppmm = ZedDB::Models.create(:user_key => opts[:user_key],
                                        :project => { :uuid => ppss['uuid'] }, :model => opts[:items])
            puts show_model(ppss, ppmm)
          rescue Zedkit::ZedkitError => zke
            puts zke end
        end

        def update(opts = {})
          begin
            ppmm = ZedDB::Models.update(:user_key => opts[:user_key], :uuid => opts[:argv][0], :model => opts[:items])
            ppss = Zedkit::Projects.get(:user_key => opts[:user_key], :uuid => ppmm['project']['uuid'])
            puts show_model(ppss, ppmm)
          rescue Zedkit::ZedkitError => zke
            puts zke end
        end

        def delete(opts = {})
          begin
            ppmm = ZedDB::Models.get(:user_key => opts[:user_key], :uuid => opts[:argv][0])
            ZedDB::Models.delete(:user_key => opts[:user_key], :uuid => opts[:argv][0])
            puts "\nDONE.\nZedDB Model Removed [#{ppmm['name']}].\n\n"
          rescue Zedkit::ZedkitError => zke
            puts zke end
        end

        def method_missing(*args)
          raise Zedkit::CLI::UnknownCommand.new(:message => "Unknown Command [#{args[0]}]")
        end

        protected
        def show_model(project, model)
             "\nZedDB Model:\n" \
          << "  : Project       : #{project['name']}\n" \
          << "  : UUID          : #{model['uuid']}\n" \
          << "  : Name          : #{model['name']}\n" \
          << "  : Resource      : #{model['plural_name']}\n" \
          << "  : Class         : #{model['model_name']}\n" \
          << "  : Associations  : #{model['associations'].count}\n" \
          << "  : Data Items    : #{model['items'].count}\n" \
          << "  : Locations     : #{model['locations'][0]}\n" \
          << "                    #{model['locations'][1]}\n" \
          << "  : Version       : #{model['version']}\n" \
          << "  : Created       : TBA\n" \
          << "  : Updated       : TBA\n" \
          << "---------------------\n\n" \
        end
      end
    end
  end
end

