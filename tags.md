---
layout: page
title: Tags
permalink: /tags/
---

<div class="tags-page">
{% assign sorted_tags = site.tags | sort %}
{% for tag in sorted_tags %}
  {% assign tag_name = tag[0] %}
  {% assign posts = tag[1] %}
  <h2 id="{{ tag_name | slugify }}">{{ tag_name }} <span class="tag-count">({{ posts | size }})</span></h2>
  <ul class="tag-posts">
  {% for post in posts %}
    <li>
      <a href="{{ post.url | relative_url }}">{{ post.title }}</a>
      <span class="post-date">{{ post.date | date: "%B %e, %Y" }}</span>
    </li>
  {% endfor %}
  </ul>
{% endfor %}
</div>
