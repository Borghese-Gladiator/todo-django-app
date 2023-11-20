from django.test import TestCase
from .models import Todo

class TodoModelTest(TestCase):
    def setUp(self):
        Todo.objects.create(title='Test Todo', description='This is a test todo.')

    def test_todo_creation(self):
        todo = Todo.objects.get(title='Test Todo')
        self.assertEqual(todo.description, 'This is a test todo.')
        # Add more test cases as needed
