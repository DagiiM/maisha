from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from .serializers import SearchSerializer

class SearchAPIView(APIView):
    def post(self, request):
        '''
        serializer = SearchSerializer(data=request.data)
        if serializer.is_valid():
            results = serializer.save()  # This will call the perform_search method in the serializer
            return Response(results, status=status.HTTP_200_OK)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
        '''
        try:
            serializer = SearchSerializer(data=request.data)
            if serializer.is_valid():
                results = serializer.save()  # This will call the perform_search method in the serializer
                return Response(results, status=status.HTTP_200_OK)
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
        except Exception as e:
            error_message = str(e)
            return Response({"error": error_message}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)


