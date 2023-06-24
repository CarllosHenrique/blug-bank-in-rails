document.addEventListener('DOMContentLoaded', function() {
    const form = document.getElementById('stock-form');
    const nameInput = document.getElementById('stock-name');

    form.addEventListener('submit', function(event) {
      if (!validateName()) {
        event.preventDefault();
        displayError('stock-name-error', 'Nome da ação nao pode ser branco!');
      }
    });

    nameInput.addEventListener('input', function() {
      clearError('stock-name-error');
    });

    function validateName() {
      return nameInput.value.trim() !== '';
    }

    function displayError(elementId, errorMessage) {
      const errorElement = document.getElementById(elementId);
      errorElement.textContent = errorMessage;
    }

    function clearError(elementId) {
      const errorElement = document.getElementById(elementId);
      errorElement.textContent = '';
    }
  });
