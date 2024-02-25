document.addEventListener('DOMContentLoaded', function() {
    const questionSelect = document.querySelector('.question-select');
    const choiceSelect = document.querySelector('.choice-select');
  
    questionSelect.addEventListener('change', function() {
      const selectedQuestionId = this.value;
  
      // Clear existing choices
      choiceSelect.innerHTML = '';
  
      if (selectedQuestionId) {
        // Fetch choices for the selected question
        fetch(`/api/choices?question_id=${selectedQuestionId}`)
          .then(response => response.json())
          .then(data => {
            // Populate the choice select field with retrieved choices
            data.forEach(choice => {
              const option = document.createElement('option');
              option.value = choice.id;
              option.textContent = choice.label;
              choiceSelect.appendChild(option);
            });
          });
      }
    });
  });
  