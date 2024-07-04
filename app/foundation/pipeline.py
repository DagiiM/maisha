
class Pipeline:
    def __init__(self):
        self.processors = []

    def add_processor(self, processor):
        self.processors.append(processor)

    def run(self, input_data):
        data = input_data
        for processor in self.processors:
            data = processor.process(data)
        return data