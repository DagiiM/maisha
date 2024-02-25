
from django.core.exceptions import ObjectDoesNotExist
import logging
from .exceptions import ErrorResponse,handle_validation_error
from rest_framework import serializers, status
from rest_framework.exceptions import (
    APIException,
    AuthenticationFailed,
    NotFound,
    PermissionDenied,
)

class BaseSerializer(serializers.ModelSerializer):
    """
    A more robust base serializer that handles exceptions and errors more gracefully.
    """

    logger = logging.getLogger(__name__)

    EXCEPTION_STATUS_MAP = {
        ErrorResponse: None,
        ObjectDoesNotExist: status.HTTP_409_CONFLICT,
        ValueError: status.HTTP_400_BAD_REQUEST,
        TypeError: status.HTTP_400_BAD_REQUEST,
        AuthenticationFailed: status.HTTP_401_UNAUTHORIZED,
        PermissionDenied: status.HTTP_403_FORBIDDEN,
        NotFound: status.HTTP_404_NOT_FOUND,
        APIException: None,
    }

    @handle_validation_error
    def to_internal_value(self, data):
        return super().to_internal_value(data)

    @handle_validation_error
    def to_representation(self, instance):
        for exception_class, default_status_code in self.EXCEPTION_STATUS_MAP.items():
            if isinstance(instance, exception_class):
                message = str(instance)
                status_code = default_status_code or instance.status_code
                error_data = ErrorResponse(message, status_code)
                raise serializers.ValidationError(error_data.errors, code=status_code)
      
        return super().to_representation(instance)

    def handle_exception(self, exc):
        if isinstance(exc, Exception):
            message = 'An unexpected error occurred during serialization'
            status_code = status.HTTP_500_INTERNAL_SERVER_ERROR
            error_data = ErrorResponse(message, status_code)
            self.logger.exception(message)
            raise serializers.ValidationError(error_data.errors, code=status_code)

        return super().handle_exception(exc)
    
