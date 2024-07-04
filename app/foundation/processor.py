from abc import ABC, abstractmethod
from django.db.models.query import QuerySet


class Processor(ABC):
    def __init__(self, batch_size=None):
        self.batch_size = batch_size

    def process(self, data):
        if not hasattr(data, '__iter__') or isinstance(data, str):
            data = [data]
        if self.batch_size:
            return self.process_in_batches(data)
        else:
            return self.process_batch(data)
        
    @abstractmethod
    def process_batch(self, batch):
        raise NotImplementedError("Subclasses must implement process_batch method")

    def process_in_batches(self, data):
        processed_data = []
        batched_data = self._batch_iterator(data, self.batch_size)
        for batch in batched_data:
            processed_batch = self.process_batch(batch)
            processed_data.extend(processed_batch)
        return processed_data

    def _batch_iterator(self, iterable, batch_size):
        """Split iterable into batches of specified size."""
        batch = []
        if isinstance(iterable, (list, QuerySet)):
            # If iterable is a list or QuerySet, process each item
            for item in iterable:
                batch.append(item)
                if len(batch) == batch_size:
                    yield batch
                    batch = []
            if batch:
                yield batch
        else:
            # If iterable is a single instance, yield it as a single-element batch
            yield [iterable]

