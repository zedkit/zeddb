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
          puts ZedDB::Model.new(:user_key => opts[:user_key], :locale => opts[:locale], :uuid => opts[:argv][0])
        end

        def create(opts = {})
          opts[:items]['name'] = opts[:argv][1]
          puts ZedDB::Model.new(:user_key => opts[:user_key], :locale => opts[:locale]).replace \
               ZedDB::Models.create(:user_key => opts[:user_key], :locale => opts[:locale],
                                    :project => { :uuid => opts[:argv][0] }, :model => opts[:items])
        end

        def update(opts = {})
          puts ZedDB::Model.new(:user_key => opts[:user_key], :locale => opts[:locale]).replace \
               ZedDB::Models.update(:user_key => opts[:user_key],
                                    :locale => opts[:locale], :uuid => opts[:argv][0], :model => opts[:items])
        end

        def delete(opts = {})
          mm = ZedDB::Model.new(:user_key => opts[:user_key], :locale => opts[:locale], :uuid => opts[:argv][0])
          mm.delete
          puts "\nDONE.\nZedDB Model Removed [#{mm.name}].\n\n"
        end

        protected
        def before_create(opts = {})
          if opts[:argv][0].nil?
            raise Zedkit::CLI::MissingParameter.new(:message => ZedDB::CLI.ee(opts[:locale], :project, :uuid)) end
          if opts[:argv][1].nil?
            raise Zedkit::CLI::MissingParameter.new(:message => ZedDB::CLI.ee(opts[:locale], :model, :name)) end
        end
        def before_show_update_delete(opts = {})
          if opts[:argv][0].nil?
            raise Zedkit::CLI::MissingParameter.new(:message => ZedDB::CLI.ee(opts[:locale], :model, :uuid)) end
        end
      end
    end
  end
end
