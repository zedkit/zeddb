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
    class Runner < Zedkit::CLI::Runner
      SECTIONS = ['projects','models','items']

      protected
      def just_do_it
        klass = Object.const_get('ZedDB').const_get('CLI').const_get(section.capitalize)
        klass.send command.to_sym, :user_key => user_key, :items => items_to_key_value_hash, :argv => ARGV
      end
      def map
           "\n" \
        << "== Project Commands\n\n" \
        << "list <uuid>                              ## List project models\n\n" \
        << "== Model Commands\n\n" \
        << "models:show <uuid>                       ## Show model details\n" \
        << "models:create <name> key=value [...]     ## Create a new model\n" \
        << "models:update <uuid> key=value [...]     ## Update an existing model\n" \
        << "models:delete <uuid>                     ## Delete an existing model\n\n" \
        << "== Model Item Commands\n\n" \
        << "items:show <uuid>                        ## Show details of a model's data items\n" \
        << "items:create <name> key=value [...]      ## Create a new data item within a model\n" \
        << "items:update <uuid> key=value [...]      ## Update an existing data item\n" \
        << "items:delete <uuid>                      ## Delete an existing data item\n\n" \
        << "==\n\n"
      end
    end
  end
end
