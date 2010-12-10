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
    class Models < Zedkit::CLI::Bottom
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
            raise Zedkit::CLI::MissingParameter.new(:message => "Project UUID is nil") if opts[:items]['project'].nil?
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

        protected
        def show_model(project, model)
          rs  = "\nZedDB Model:\n"
          rs << "  : Project       : #{project['name']}\n"
          rs << "  : UUID          : #{model['uuid']}\n"
          rs << "  : Name          : #{model['name']}\n"
          rs << "  : Resource      : #{model['plural_name']}\n"
          rs << "  : Class         : #{model['model_name']}\n"
          rs << "  : Associations  : #{model['associations'].count}\n"
          rs << "  : Data Items    : #{model['items'].count}\n"
          rs << "  : Locations     : #{model['locations'][0]}\n"
          rs << "                    #{model['locations'][1]}\n"
          rs << "  : Version       : #{model['version']}\n"
          rs << "  : Created       : #{Time.at(model['created_at']).to_date}\n"
          rs << "  : Updated       : #{Time.at(model['updated_at']).to_date}\n"
          if model['items'].empty?
            rs << "---------------------\n"
          else
            rs << line << "| #{'Model Data Items'.ljust(88)} |\n" << line
            rs << "| #{'UUID'.ljust(32)} | #{'Name'.ljust(32)} | #{'Type'.ljust(18)} |\n" << line
            model['items'].each {|mi| rs << "| #{uuid(mi)} | #{name(mi)} | #{type(mi)} |\n" }
            rs << line
          end
          rs << "\n"
        end

        private
        def line
          Array.new(92,'-').join << "\n"
        end
        def uuid(mi)
          mi['uuid'].ljust(32)
        end
        def name(mi)
          mi['name'].ljust(32)
        end
        def type(mi)
          mi['type']['code'].ljust(18)
        end
      end
    end
  end
end

