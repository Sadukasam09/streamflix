function createForm() {
    // Check if the form already exists to prevent multiple forms
    if (document.getElementById('dynamicLoginForm')) return;

    // Create form element
    const form = document.createElement('form');
    form.setAttribute('id', 'dynamicLoginForm');
    form.setAttribute('method', 'post');
    form.setAttribute('action', '/login');

    // Create input for username
    const usernameInput = document.createElement('input');
    usernameInput.setAttribute('type', 'text');
    usernameInput.setAttribute('name', 'username');
    usernameInput.setAttribute('placeholder', 'Username');

    //crete email
    const emailInput = document.createElement('input');
    emailInput.setAttribute('type','text');
    emailInput.setAttribute('name','email');
    emailInput.setAttribute('placeholder','email');

    // Create input for password
    const passwordInput = document.createElement('input');
    passwordInput.setAttribute('type', 'password');
    passwordInput.setAttribute('name', 'password');
    passwordInput.setAttribute('placeholder', 'Password');



    //

    // Create a submit button
    const submitButton = document.createElement('button');
    submitButton.setAttribute('type', 'submit');
    submitButton.textContent = 'register';

    // Append inputs and button to form
    form.appendChild(usernameInput);
    form.appendChild(emailInput);
    form.appendChild(passwordInput);
    form.appendChild(submitButton);
    

    // Append form to the container
    document.getElementById('formContainer').appendChild(form);
// Add class to form container
document.getElementById('formContainer').classList.add('form-container');

// Add class to inputs
nameInput.classList.add('form-input');
emailInput.classList.add('form-input');
passwordInput.classList.add('form-input');
confirmPasswordInput.classList.add('form-input');

// Add class to submit button
submitButton.classList.add('form-button');// Style form container
document.getElementById('formContainer').style.padding = '10px';
document.getElementById('formContainer').style.border = '1px solid #ccc';
document.getElementById('formContainer').style.borderRadius = '5px';
document.getElementById('formContainer').style.boxShadow = '0 0 10px rgba(0, 0, 0, 0.1)';
document.getElementById('formContainer').style.width = '50%';
document.getElementById('formContainer').style.margin = 'auto';

// Style inputs
[nameInput, emailInput, passwordInput, confirmPasswordInput].forEach(input => {
    input.style.padding = '10px';
    input.style.margin = '10px 0';
    input.style.border = '1px solid #ccc';
    input.style.borderRadius = '5px';
});

// Style submit button
submitButton.style.padding = '10px 20px';
submitButton.style.backgroundColor = '#007bff';
submitButton.style.color = 'white';
submitButton.style.border = 'none';
submitButton.style.borderRadius = '5px';
submitButton.style.cursor = 'pointer';
submitButton.onmouseover = () => submitButton.style.backgroundColor = '#0056b3';
submitButton.onmouseleave = () => submitButton.style.backgroundColor = '#007bff';
}