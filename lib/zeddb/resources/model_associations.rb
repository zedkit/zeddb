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
  class ModelAssociations
    class << self
      #
      # = ZedDB Model Associations
      #
      # ZedDB models can be associated with each other in predetermined ways. You can create or delete model associations.
      # A model's associations are listed within its response data set.
      #
      # To create a new Model Assocation you submit the required parameters of the association type with the model UUIDs that
      # you are creating an association between. Whatever items you send within the :association Hash are passed through to
      # the ZedAPI untouched. There is no client side validation within this gem.
      #
      # Associations can be confusing to create, given that the order is arbitary. But you would read an association as
      # Model B belongs to Model A. So, to create a belongs_to association. You would be using the resource location based
      # on Model B, creating an association to Model A, with "first" and "second" labels as you read the association aloud.
      #
      #   ZedDB::ModelAssociations.create(:user_key => user['user_key'],
      #                                   :association => { :first => model_b['uuid'],
      #                                                     :code => 'BT', :inverse => 'HM', :second => model_b['uuid] })
      #
      # To delete a Model Association:
      #
      #   ZedDB::ModelAssociations.delete(:user_key => user['user_key'], :uuid => association['uuid])
      #
      # From each of these requests the Zedkit::Client class will return a response hash for your reference, if needed,
      # or as applicable to the request. If there was a HTTP 401 or 404 you will get a nil response. This indicates a
      # security failure or that an UUID is incorrect, not attached the user's account, or non-existent.
      #
      # For each request you can also pass a block to process the response directly:
      #
      #   ZedDB::ModelAssociations.delete(:user_key => user['user_key'], :uuid => association['uuid]) do |result|
      #   end
      #

      def get(zks = {}, &block)
        Zedkit::Client.crud(:get, "db/associations/#{zks[:uuid]}", zks, [], &block)
      end

      def create(zks = {}, &block)
       Zedkit::Client.crud(:create, 'db/associations', zks, [], &block)
      end

      def delete(zks = {}, &block)
       Zedkit::Client.crud(:delete, "db/associations/#{zks[:uuid]}", zks, [], &block)
      end
    end
  end
end
