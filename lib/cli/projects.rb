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
    class Projects < Zedkit::CLI::Bottom
      class << self
        def list(opts = {})
          show_models Zedkit::Project.new(:user_key => opts[:user_key], :locale => opts[:locale], :uuid => opts[:argv][0])
        end
        def codes(opts = {})
          puts "\n" << ZedDB::CLI.ee(opts[:locale], :general, :not_done) << "\n\n"
        end

        protected
        def before_list(opts = {})
          if opts[:argv][0].nil?
            raise Zedkit::CLI::MissingParameter.new(:message => ZedDB::CLI.ee(opts[:locale], :project, :nil)) end
        end
        def show_models(project)
          mcnt = "[#{project.models.length} #{project.models.length > 1 ? 'Models' : 'Model'}]"
          puts dashes(122) \
            << "| " << "ZedDB Models [#{project.name}] #{mcnt}".ljust(118) << " |\n" \
            << dashes(122) \
            << "| #{'UUID'.ljust(32)} | #{'Name'.ljust(32)} | #{'Location'.ljust(48)} |\n" \
            << dashes(122)
          project.models.each do |mm|
            puts "| #{mm['uuid'].ljust(32)} | #{mm['name'].ljust(32)} | #{mm['locations'][0].ljust(48)} |\n"
          end
          puts dashes(122)
        end
      end
    end
  end
end
