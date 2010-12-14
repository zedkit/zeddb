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
  class Models
    class << self
      #
      # = ZedDB Database Models
      #
      # All ZedDB application databases have models. You can create, read, update, or delete models. To perform an 
      # operation on a specific model you need its UUID, as available from the Websites.models method.
      #
      # To get a Model:
      #
      #   ZedDB::Models.get(:user_key => user['user_key'], :uuid => model['uuid'])
      #
      # To update a Model:
      # 
      #   ZedDB::Models.update(:user_key => user['user_key'], :uuid => model['uuid'])
      #
      # To delete a Model:
      #
      #   ZedDB::Models.delete(:user_key => user['user_key'], :uuid => model['uuid'])
      #
      # To create a new Model you submit the required parameters with the project UUID that you are creating the 
      # model for. Whatever items you send within the :model Hash are passed through to the ZedAPI untouched.
      # There is no client side validation within this gem.
      #
      #   ZedDB::Models.create(:user_key => user['user_key'],
      #                        :project => { :uuid => project['uuid'] }, :model => { :name => 'whatever' })
      #
      # From each of these requests the Zedkit::Client class will return a response hash for your reference, if needed,
      # or as applicable to the request. If there was a HTTP 401 or 404 you will get a nil response. This indicates a
      # security failure or that an UUID is incorrect, not attached the user's account, or non-existent.
      #
      # For each request you can also pass a block to process the response directly:
      #
      #   ZedDB::Models.get(:user_key => user['user_key'], :uuid => model['uuid']) do |result|
      #   end
      #

      def get(zks = {}, &block)
        Zedkit::Client.crud(:get, "db/models/#{zks[:uuid]}", zks, [], &block)
      end

      def create(zks = {}, &block)
        Zedkit::Client.crud(:create, 'db/models', zks, [], &block)
      end

      def update(zks = {}, &block)
        Zedkit::Client.crud(:update, "db/models/#{zks[:uuid]}", zks, [], &block)
      end
      
      def delete(zks = {}, &block)
        Zedkit::Client.crud(:delete, "db/models/#{zks[:uuid]}", zks, [], &block)
      end
    end
  end
end
