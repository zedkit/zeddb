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

module Zedkit
  class Projects
    class Models
      class << self
        #
        # = ZedDB Application Databases
        #
        # All projects/applications have an assigned database whether they use it or not. We just bypass the concept of a
        # separate database API resource. You ask the project/application directly for the models setup within its database:
        #
        #   Zedkit::Projects.Models.get(:user_key => user['user_key'], :project => { :uuid => project['uuid'] })
        #
        # Each Zedkit project/application has an unique UUID available within the user's projects list, which you can then use
        # here, and with all methods that collect objects attached to a project/application.
        #

        def get(*args)
          zopts = args.extract_zedkit_options!
          reshh = Zedkit::Client.get('db/models', zopts[:user_key], zopts.zdelete_keys!(%w(user_key)))
          yield(reshh) if (not reshh.nil?) && block_given?
          reshh
        end
      end
    end
  end
end
