/*const error_text_elem_username = document.getElementById('error_text_username');
const error_text_elem_password1 = document.getElementById('error_text_password1');
const error_text_elem_password2 = document.getElementById('error_text_password2');
const error_text_elem_email = document.getElementById('error_text_email');
const error_text_elem_first_name = document.getElementById('error_text_first_name');
const error_text_elem_last_name = document.getElementById('error_text_last_name');
const error_text_elem_street = document.getElementById('error_text_street');
const error_text_elem_city = document.getElementById('error_text_city');
const error_text_elem_postcode = document.getElementById('error_text_postcode');
const error_text_elem_country = document.getElementById('error_text_country');
const error_text_elem_housenumber = document.getElementById('error_text_housenumber');*/

function handleError(error){
    console.log(error)
}

function submitForm(){
    formObj = {
        username: document.getElementById('username').value,
        password1: document.getElementById('password1').value,
        password2: document.getElementById('password2').value,
        email: document.getElementById('email').value,
        first_name: document.getElementById('firstname').value,
        last_name: document.getElementById('lastname').value,
        street: document.getElementById('street').value,
        city: document.getElementById('city').value,
        postcode: document.getElementById('postcode').value,
        country: document.getElementById('country').value,
        housenumber: document.getElementById('housenumber').value,
    }

    $.ajax({
        url : "/auth/register",
        type: "POST",
        data : formObj,
        success: function(data)
        {
            if(data == 0){
                window.location.href = "/login";
            }else{
                handleError(data);
            }
        },
        error: function (jqXHR, textStatus, errorThrown)
        {
            console.log(jqXHR);
            console.log(textStatus);
            console.log(errorThrown);
        }
    });
}

