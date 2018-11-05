from app import app
import unittest

class EndpointTests(unittest.TestCase):

	def setUp(self):
		self.app = app.test_client()
		self.app.testing = True

	def test_RouteHome(self):
		result = self.app.get('/')
		self.assertEqual(result.status_code, 200)

	def test_RestRouteList(self):
		result = self.app.get('/list')
		self.assertEqual(result.status_code, 200)

	def test_EmployeeCreation(self):
		response = self.app.post('/add', data=dict(gender="F", first_name="UnitTest", last_name="UnitTest", birth_date="2000-12-12"))
		self.assertEqual(response.status_code, 200)

if __name__ == '__main__':
    unittest.main()
