---
layout: post

---

<ul class="posts">
  {% for post in site.posts %}
  <h3>{{ post.title }}</h3>
  {{ post.content }}
  {% endfor %}
</ul>
