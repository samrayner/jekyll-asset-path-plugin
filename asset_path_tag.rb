# Title: Asset path tag for Jekyll
# Authors:
#     Sam Rayner http://samrayner.com
#     Otto Urpelainen http://koti.kapsi.fi/oturpe/projects/
#
# Description: Output a relative URL for assets based on the post or page
#
# Syntax
#    {% asset_path filename post_id %}
#    {% asset_path "filename with whitespace" post_id %}
#
# Examples:
# {% asset_path kitten.png %} on post 2013-01-01-post-title
# {% asset_path pirate.mov %} on page page-title
# {% asset_path document.pdf /2012/05/25/another-post-title %}
# {% asset_path "document with spaces in name.pdf" /2012/05/25/another-post-title %}
#
# Output:
# /assets/posts/post-title/kitten.png
# /assets/page-title/pirate.mov
# /assets/posts/another-post-title/document.pdf
# /assets/posts/another-post-title/document with spaces in name.pdf
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
# {% for post in site.posts %}{% asset_path cover.jpg {{post.id}} %}{% endfor %} on index.html
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
        return "Error processing input, expected syntax: {% asset_path filename post_id %}"
      end

      #render the markup
      parameters = Liquid::Template.parse(@markup).render context
      parameters.strip!

      if ['"', "'"].include? parameters[0] 
        # Quoted filename, possibly followed by post id
        last_quote_index = parameters.rindex(parameters[0])
        filename = parameters[1 ... last_quote_index]
        post_id = parameters[(last_quote_index + 1) .. -1].strip
      else
        # Unquoted filename, possibly followed by post id
        filename, post_id = parameters.split(/\s+/)
      end

      page = context.environments.first["page"]

      post_id = page["id"] if post_id == nil or post_id.empty?
      if post_id
        #if a post
        posts = context.registers[:site].posts
        path = Jekyll.get_post_path(post_id, posts)
      else
        path = page["url"]
      end

      #strip filename
      path = File.dirname(path) if path =~ /\.\w+$/

      #fix double slashes
      "#{context.registers[:site].config['baseurl']}/assets/#{path}/#{filename}".gsub(/\/{2,}/, '/')
    end
  end
end

Liquid::Template.register_tag('asset_path', Jekyll::AssetPathTag)
