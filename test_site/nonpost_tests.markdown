---
title:  "jekyll-thumbnail-generator non-post tests"
permalink: /nonpost_tests/
---
Nonpost tests

## This page

### Unquoted: nonpost.png
![Failure]({% asset_path nonpost.png %})

### Double quotes: "nonpost.png"
![Failure]({% asset_path "nonpost.png" %})

### Single quotes: 'nonpost.png'
![Failure]({% asset_path 'nonpost.png' %})

### Quoted with spaces: "nonpost with space.png"
![Failure]({% asset_path "nonpost with space.png" %})

### Single quotes with spaces: 'nonpost with space.png'
![Failure]({% asset_path 'nonpost with space.png' %})
