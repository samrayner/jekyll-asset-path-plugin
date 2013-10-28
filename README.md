Jekyll Asset Path Tag
=====================

A liquid tag to output a relative URL for assets based on the post or page, allowing you to organise your assets into subdirectories.

Syntax: `{% asset_path [filename] %}`

##Installation
Copy asset_path_tag.rb into */_plugins* ([Jekyll][j]) or */plugins* ([Octopress][o])

##Examples

```
{% asset_path my-image.png %}
```
in post 2013-01-01-post-title would output:
```
/assets/posts/post-title/my-image.png
```
in page my-first-page would output:
```
/assets/my-first-page/my-image.png
```

Useful for images and links in Markdown or HTML:
```
[Download script]({% asset_path my-script.js %})
<img src="{% asset_path my-image.png %}" alt="My Image" />
```

[j]: http://jekyllrb.com/
[o]: http://octopress.org/
