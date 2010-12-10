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
    class Projects
      class << self
        def list(opts = {})
          begin
            ppss = Zedkit::Projects.get(:user_key => opts[:user_key], :uuid => opts[:argv][0])
            ppmm = Zedkit::Projects::Models.get(:user_key => opts[:user_key], :project => { :uuid => ppss['uuid'] })
            puts show_models(ppss, ppmm)
          rescue Zedkit::ZedkitError => zke
            puts zke end
        end

        def method_missing(*args)
          raise Zedkit::CLI::UnknownCommand.new(:message => "Unknown Command [#{args[0]}]")
        end

        protected
        def show_models(project, models)
          tt = "ZedDB Models [#{project['name']}] [#{models.length} #{models.length > 1 ? 'Models' : 'Model'}]"
          rs = line << "| #{tt.ljust(118)} |\n" << line
          rs << "| #{'Name'.ljust(32)} | #{'UUID'.ljust(32)} | #{'Location'.ljust(48)} |\n" << line
          models.each {|mm| rs << "| #{uuid(mm)} | #{name(mm)} | #{location(mm)} |\n" }
          rs << line
        end

        private
        def line
          Array.new(122,'-').join << "\n"
        end
        def uuid(mm)
          mm['uuid'].ljust(32)
        end
        def name(mm)
          mm['name'].ljust(32)
        end
        def location(mm)
          mm['locations'][0].ljust(48)
        end
      end
    end
  end
end

