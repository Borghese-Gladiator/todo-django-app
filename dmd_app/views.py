import markdown
from django.shortcuts import render
from .models import MarkdownContent

def markdown_content_view(request):
    md = markdown.Markdown(extensions=["fenced_code"])
    markdown_content = MarkdownContent.objects.first()
    markdown_content.content = md.convert(markdown_content.content)
    context = {"markdown_content": markdown_content}
    return render(
        request,
        "dmd_app/markdown_content.html",
        context=context
    )