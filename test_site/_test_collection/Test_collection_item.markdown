---
title: "Test collection item"
---

Test collection document.

## This document

### Unquoted: this-collection-item.png
![Failure]({% asset_path this-collection-item.png %})

### Double quotes: "this-collection-item.png"
![Failure]({% asset_path "this-collection-item.png" %})

### Single quotes: 'this-collection-item.png'
![Failure]({% asset_path 'this-collection-item.png' %})

### Quoted with spaces: "this collection item with space.png"
![Failure]({% asset_path "this collection item with space.png" %})

### Single quotes with spaces: 'this collection item with space.png'
![Failure]({% asset_path 'this collection item with space.png' %})

## Document in default collection 'posts'

### Unquoted: another-page.png /2000/01/02/Another_page
![Failure]({% asset_path another-page.png /2000/01/02/Another_page %})

### Double quotes: "another-page.png" /2000/01/02/Another_page
![Failure]({% asset_path "another-page.png" /2000/01/02/Another_page %})

### Single quotes: 'another-page.png' /2000/01/02/Another_page
![Failure]({% asset_path 'another-page.png' /2000/01/02/Another_page %})

### Double quotes with space: "another page with space.png" /2000/01/02/Another_page
![Failure]({% asset_path "another page with space.png" /2000/01/02/Another_page %})

### Single quotes with space: 'another page with space.png' /2000/01/02/Another_page
![Failure]({% asset_path 'another page with space.png' /2000/01/02/Another_page %})

## Document in another collection

### Unquoted: another.png Another another_collection
![Failure]({% asset_path another.png /another_collection/Another %})

### Double quotes: "another.png" Another another_collection
![Failure]({% asset_path "another.png" /another_collection/Another %})

### Single quotes: 'another.png' Another another_collection
![Failure]({% asset_path 'another.png' /another_collection/Another %})

### Double quotes with space: "another with space.png" Another another_collection
![Failure]({% asset_path "another with space.png" /another_collection/Another %})

### Single quotes with space: 'another with space.png' Another another_collection
![Failure]({% asset_path 'another with space.png' /another_collection/Another %})

<!-- TODO: More cases needed? -->
