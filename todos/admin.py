from django.contrib import admin
from .models import Todo, MarkdownContent

admin.site.register(Todo)
admin.site.register(MarkdownContent)