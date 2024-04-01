# frozen_string_literal: true

# Copyright (c) 2014-2024 Yegor Bugayenko
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the 'Software'), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so. The Software doesn't include files with .md extension.
# That files you are not allowed to copy, distribute, modify, publish, or sell.
#
# THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

# Jekyll module
module Jekyll
  # The module
  module Tags
    # The class
    class Pst < Liquid::Tag
      def initialize(tag_name, post, tokens)
        super
        @post = post.strip
        @file = "_posts/#{@post}.md"
        raise "File #{@file} doesn't exist" unless File.exist?(@file)
      end

      def render(context)
        context.registers[:site].posts.docs.each do |p|
          return p.url if p.relative_path == @file
        end
        raise "Can't find post with \"#{@post}\" name"
      end
    end
  end
end

Liquid::Template.register_tag('pst', Jekyll::Tags::Pst)
