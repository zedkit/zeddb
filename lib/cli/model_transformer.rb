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
    class Trans < Zedkit::CLI::Bottom
      class << self
        def create(opts = {})
          opts[:items]['code'] = opts[:argv][1]
          mt = ZedDB::ModelTransformer.new(:user_key => opts[:user_key], :locale => opts[:locale]).replace \
               ZedDB::ModelTransformers.create(:user_key => opts[:user_key], :locale => opts[:locale],
                                               :item => { :uuid => opts[:argv][0] }, :transformer => opts[:items])
          puts mt.model_item
        end
 
        def delete(opts = {})
          mt = ZedDB::ModelTransformer.new(:user_key => opts[:user_key],
                                           :locale => opts[:locale], :owner => opts[:argv][0], :uuid => opts[:argv][1])
          mt.delete
          puts "\nDONE.\nZedDB Model Transformer Removed [#{mt.transformer['code']}].\n\n"
        end

        protected
        def before_create(opts = {})
          if opts[:argv][0].nil?
            raise Zedkit::CLI::MissingParameter.new(:message => ZedDB::CLI.ee(opts[:locale], :item, :uuid)) end
          if opts[:argv][1].nil?
            raise Zedkit::CLI::MissingParameter.new(:message => ZedDB::CLI.ee(opts[:locale], :transformer, :code)) end
        end
        def before_show_update_delete(opts = {})
          if opts[:argv][0].nil?
            raise Zedkit::CLI::MissingParameter.new(:message => ZedDB::CLI.ee(opts[:locale], :item, :uuid)) end
          if opts[:argv][1].nil?
            raise Zedkit::CLI::MissingParameter.new(:message => ZedDB::CLI.ee(opts[:locale], :transformer, :uuid)) end
        end
      end
    end
  end
end
