from django.http import JsonResponse
from rest_framework.views import exception_handler
import json
from rest_framework import serializers
from rest_framework.exceptions import APIException

class ErrorResponse(APIException):
    """
    A standard error response format.
    """

    def __init__(self, message, status_code=None):
        self.status_code = status_code
        self.detail = message
        super().__init__(detail=message, code=status_code)

    @classmethod
    def custom_validation_error(cls, message, status_code=None):
        return cls(message=message, status_code=status_code)

    def to_dict(self):
        return {"detail": self.detail, "status_code": self.status_code}

    def to_json(self):
        return json.dumps(self.to_dict())

def handle_validation_error(func):
    def wrapper(self, *args, **kwargs):
        try:
            return func(self, *args, **kwargs)
        except serializers.ValidationError as e:
            raise ErrorResponse.custom_validation_error(str(e), status_code=400)
    return wrapper


def my_exception_handler(exc, context):
    if isinstance(exc, ErrorResponse):
        error_response = exc.to_dict()
        message = error_response['errors'][0]['message']
        return JsonResponse({'error': message}, status=exc.status_code)
    else:
        # Call REST framework's default exception handler
        response = exception_handler(exc, context)

        if response is not None:
            return response

        # Handle other exceptions here
        # ...

        # Return a default error response
        return JsonResponse({'error': 'Internal Server Error'}, status=500)