# Title: Asset path tag for Jekyll
# Author: Sam Rayner http://samrayner.com
# Description: Output a relative URL for assets based on the post or page
#
# Syntax
#    {% asset_path [filename] %}
#    {% page_asset_path [page_id] [filename] %}
#
# Examples:
# {% asset_path kitten.png %} on post 2013-01-01-post-title
# {% asset_path pirate.mov %} on page page-title
# {% page_asset_path /2012/05/25/another-post-title document.pdf %}
#
# Output:
# /assets/posts/post-title/kitten.png
# /assets/page-title/pirate.mov
# /assets/posts/another-post-title/document.pdf
#
# Looping example using a variable for the pathname:
#
# File _data/image.csv contains:
#   file
#   image_one.png
#   image_two.png
#
# {% for image in site.data.images %}{% asset_path {{ image.file }} %}{% endfor %} on post 2015-03-21-post-title
#
# Output:
# /assets/posts/post-title/image_one.png
# /assets/posts/post-title/image_two.png
#
# Looping example over posts:
#
# Site contains posts:
#   post-title
#   another-post-title
#
# {% for post in site.posts %}{% page_asset_path {{post.id}} cover.jpg %}{% endfor %} on index.html
#
# Output:
# /assets/posts/post-title/cover.jpg
# /assets/posts/another-post-title/cover.jpg

module Jekyll

  def self.get_post_path(page_id, posts)
    #check for Jekyll version
    if Jekyll::VERSION < '3.0.0'
      #loop through posts to find match and get slug
      posts.each do |post|
        if post.id == page_id
          return "posts/#{post.slug}"
        end
      end
    else
      #loop through posts to find match and get slug, method calls for Jekyll 3
      posts.docs.each do |post|
        if post.id == page_id
          return "posts/#{post.data['slug']}"
        end
      end
    end

    return ""
  end

  class AssetPathTag < Liquid::Tag
    @markup = nil

    def initialize(tag_name, markup, tokens)
      #strip leading and trailing spaces
      @markup = markup.strip
      super
    end

    def render(context)
      if @markup.empty?
        return "Error processing input, expected syntax: {% asset_path [filename] %}"
      end

      #render the markup
      rawFilename = Liquid::Template.parse(@markup).render context

      #strip leading and trailing quotes
      filename = rawFilename.gsub(/^("|')|("|')$/, '')

      page = context.environments.first["page"]

      #if a post
      if page["id"]
        posts = context.registers[:site].posts
        path = Jekyll.get_post_path(page["id"], posts)
      else
        path = page["url"]
      end

      #strip filename
      path = File.dirname(path) if path =~ /\.\w+$/

      #fix double slashes
      "#{context.registers[:site].config['baseurl']}/assets/#{path}/#{filename}".gsub(/\/{2,}/, '/')
    end
  end

  class PageAssetPathTag < Liquid::Tag
    @markup = nil

    def initialize(tag_name, markup, tokens)
      #strip leading and trailing spaces
      @markup = markup.strip
      super
    end

    def render(context)
      if @markup.empty?
        return "Error processing input, expected syntax: {% page_asset_path [page_id] [filename] %}"
      end

      # render the page markup
      parsed = Liquid::Template.parse(@markup).render context
      id, filename = parsed.split(' ', 2).each do |param|
        unquoted = param.gsub(/^("|')|("|')$/, '')
        unquoted.strip
      end
    
      posts = context.registers[:site].posts
      path = Jekyll.get_post_path(id, posts)
      path = File.dirname(path) if path =~ /\.\w+$/

      root = context.registers[:site].config['baseurl']
      #fix double slashes
      "#{root}/assets/#{path}/#{filename}".gsub(/\/{2,}/, '/')
    end
  end
end

Liquid::Template.register_tag('asset_path', Jekyll::AssetPathTag)
Liquid::Template.register_tag('page_asset_path', Jekyll::PageAssetPathTag)
