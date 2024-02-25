from django.apps import apps
from .models import SearchableModel
from app.serializers import BaseSerializer
from rest_framework import serializers, status

class SearchSerializer(serializers.Serializer):
    query = serializers.CharField()

    def create(self, validated_data):
        query = validated_data['query']
        models = self.get_searchable_models()
        results = self.search_models(query, models)
        return results

    def search_models(self, query, models):
        results = {}
        for model in models:
            serializer_class = self.get_serializer_class(model)
            queryset = model.search_queryset(query=query, serializer_class_=serializer_class)

            if queryset: 
                serializer = serializer_class(queryset,context={'query':query})
                results[model.__name__] = serializer.data
                
        return queryset

        
    def get_searchable_models(self):
        """
        Get a list of models that have a `search_queryset` method and inherit from `SearchableMixin`.
        """
        searchable_models = []
        for model in apps.get_models():
            if issubclass(model, SearchableModel) and hasattr(model, 'search_fields') and hasattr(model, 'fields_to_return'):
                searchable_models.append(model)
        return searchable_models

    def get_serializer_class(self, model):
        fields_to_return = getattr(model, 'fields_to_return', [])
        
        if fields_to_return:
            class_name = f'{model.__name__}Serializer'
            meta_attrs = {
                'model': model,
                'fields': fields_to_return
            }
            
            Meta = type('Meta', (object,), meta_attrs)
            attrs = {'Meta': Meta}
            
            serializer_class = type(class_name, (serializers.ModelSerializer,), attrs)
        
            return serializer_class

    def to_representation(self, instance):
        return self.search_models(instance['query'], self.get_searchable_models())
