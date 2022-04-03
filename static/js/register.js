const error_text_elem_general = document.getElementById('error_text_general');
const error_text_elem_username = document.getElementById('error_text_username');
const error_text_elem_password1 = document.getElementById('error_text_password1');
const error_text_elem_password2 = document.getElementById('error_text_password2');
const error_text_elem_email = document.getElementById('error_text_email');
const error_text_elem_firstname = document.getElementById('error_text_firstname');
const error_text_elem_lastname = document.getElementById('error_text_lastname');
const error_text_elem_street = document.getElementById('error_text_street');
const error_text_elem_city = document.getElementById('error_text_city');
const error_text_elem_postcode = document.getElementById('error_text_postcode');
const error_text_elem_country = document.getElementById('error_text_country');
const error_text_elem_housenumber = document.getElementById('error_text_housenumber');
const error_text_elem_gender = document.getElementById('error_text_gender');

const username_elem = document.getElementById('username');
const password1_elem = document.getElementById('password1');
const password2_elem = document.getElementById('password2');
const email_elem = document.getElementById('email');
const firstname_elem = document.getElementById('firstname');
const lastname_elem = document.getElementById('lastname');
const street_elem = document.getElementById('street');
const city_elem = document.getElementById('city');
const postcode_elem = document.getElementById('postcode');
const country_elem = document.getElementById('country');
const housenumber = document.getElementById('housenumber');
const gender = document.getElementById('gender')

function handleError(error){
    
    if(!error){
        error_text_elem_general.textContent = "Fehler beim Registrieren";
        return;
    }

    error = error.split("_");
    console.log(error)

    if(error[1] == "username"){
        str = "";

        switch(error[2]){
            case "short":
                str = "Der Benutzername ist zu kurz <br> -> mindestens 3 Zeichen";
                break;
            case "long":
                str = "Der Benutzername ist zu lang <br> -> maximal 30 Zeichen";
                break;
            case "invalid":
                str = "Der Benutzername ist ungültig <br> -> nur Buchstaben und Zahlen";
                break;
            case "duplicate":
                str = "Der Benutzername ist bereits vergeben";
                break;
            default:
                str = error[2];
                break;
        }
        username_elem.classList.add("input_error");
        error_text_elem_username.innerHTML = str;
    }

    if(error[1] == "password"){
        str = "";

        switch(error[2]){
            case "short":
                str = "Das Passwort ist zu kurz <br> -> mindestens 8 Zeichen";
                break;
            case "long":
                str = "Das Passwort ist zu lang <br> -> maximal 200 Zeichen";
                break;
            case "invalid":
                str = "Das Passwort ist ungültig <br> -> nur Buchstaben, Zahlen und ausgewählte Sonderzeichen (!@#$%^&*.,;:)";
                break;
            case "mismatch":
                str = "Die Passwörter stimmen nicht überein";
                password2_elem.classList.add("input_error");
                break;
            default:
                str = error[2];
                break;
        }
        password1_elem.classList.add("input_error");
        error_text_elem_password1.innerHTML = str;
    }
    if(error[1] == "email"){
        str = "";

        switch(error[2]){
            case "invalid":
                str = "Die E-Mail-Adresse ist ungültig";
                break;
            case "duplicate":
                str = "Die E-Mail-Adresse ist bereits vergeben";
                break;
            default:
                str = error[2];
                break;
        }
        email_elem.classList.add("input_error");
        error_text_elem_email.innerHTML = str;
    }
    if(error[1] == "firstname"){
        str = "";

        switch(error[2]){
            case "short":
                str = "Der Vorname ist zu kurz <br> -> mindestens 1 Zeichen";
                break;
            case "long":
                str = "Der Vorname ist zu lang <br> -> maximal 80 Zeichen";
                break;
            case "invalid":
                str = "Der Vorname ist ungültig <br> -> nur Buchstaben und Bindestriche";
                break;
            default:
                str = error[2];
                break;
        }
        firstname_elem.classList.add("input_error");
        error_text_elem_firstname.innerHTML = str;
    }
    if(error[1] == "lastname"){
        str = "";

        switch(error[2]){
            case "short":
                str = "Der Nachname ist zu kurz <br> -> mindestens 1 Zeichen";
                break;
            case "long":
                str = "Der Nachname ist zu lang <br> -> maximal 80 Zeichen";
                break;
            case "invalid":
                str = "Der Nachname ist ungültig <br> -> nur Buchstaben und Bindestriche";
                break;
            default:
                str = error[2];
                break;
        }
        lastname_elem.classList.add("input_error");
        error_text_elem_lastname.innerHTML = str;
    }
    if(error[1] == "street"){
        str = "";

        switch(error[2]){
            case "short":
                str = "Die Straße ist zu kurz <br> -> mindestens 2 Zeichen";
                break;
            case "long":
                str = "Die Straße ist zu lang <br> -> maximal 80 Zeichen";
                break;
            case "invalid":
                str = "Die Straße ist ungültig <br> -> nur Buchstaben, Zahlen uns Leerzeichen";
                break;
            default:
                str = error[2];
                break;
        }
        street_elem.classList.add("input_error");
        error_text_elem_street.innerHTML = str;
    }
    if(error[1] == "city"){
        str = "";

        switch(error[2]){
            case "short":
                str = "Die Stadt ist zu kurz <br> -> mindestens 1 Zeichen";
                break;
            case "long":
                str = "Die Stadt ist zu lang <br> -> maximal 80 Zeichen";
                break;
            case "invalid":
                str = "Die Stadt ist ungültig <br> -> nur Buchstaben, Zahlen und Leerzeichen";
                break;
            default:
                str = error[2];
                break;
        }
        city_elem.classList.add("input_error");
        error_text_elem_city.innerHTML = str;
    }
    if(error[1] == "postcode"){
        str = "";
        
        switch(error[2]){
            case "short":
                str = "Die Postleitzahl ist zu kurz <br> -> mindestens 1 Zeichen";
                break;
            case "long":
                str = "Die Postleitzahl ist zu lang <br> -> maximal 20 Zeichen";
                break;
            case "invalid":
                str = "Die Postleitzahl ist ungültig <br> -> nur Zahlen";
                break;
            default:
                str = error[2];
                break;
        }
        postcode_elem.classList.add("input_error");
        error_text_elem_postcode.innerHTML = str;
    }
    if(error[1] == "country"){
        str = "";

        switch(error[2]){
            case "short":
                str = "Das Land ist zu kurz <br> -> mindestens 1 Zeichen";
                break;
            case "long":
                str = "Das Land ist zu lang <br> -> maximal 80 Zeichen";
                break;
            case "invalid":
                str = "Das Land ist ungültig <br> -> nur Buchstaben, Zahlen und Leerzeichen";
                break;
            default:
                str = error[2];
                break;
        }
        error_text_elem_country.innerHTML = str;
    }
    if(error[1] == "housenumber"){
        str = "";

        switch(error[2]){
            case "invalid":
                str = "Die Hausnummer ist ungültig <br> -> nur Zahlen";
                break;
            default:
                str = error[2];
                break;
        }
        housenumber_elem.classList.add("input_error");
        error_text_elem_housenumber.innerHTML = str;
    }
    if(error[1] == "gender"){
        str = ""

        switch(error[2]){
            case "short":
                str = "Die Anrede ist zu kurz <br> -> mindestens 1 Zeichen";
                break;
            case "long":
                str = "Die Anrede ist zu lang <br> -> maximal 15 Zeichen";
                break;
            case "invalid":
                str = "Die Anrede ist ungültig <br> -> nur Buchstaben, Leerzeichen und ausgewählter Zeichen (. -)";
                break;
            default:
                str = error[2];
                break;
        }


        error_text_elem_gender.innerHTML = str;
    }


}

function resetErrors(){
    error_text_elem_general.innerHTML = "";
    error_text_elem_username.innerHTML = "";
    error_text_elem_password1.innerHTML = "";
    error_text_elem_password2.innerHTML = "";
    error_text_elem_email.innerHTML = "";
    error_text_elem_firstname.innerHTML = "";
    error_text_elem_lastname.innerHTML = "";
    error_text_elem_street.innerHTML = "";
    error_text_elem_city.innerHTML = "";
    error_text_elem_postcode.innerHTML = "";
    error_text_elem_country.innerHTML = "";
    error_text_elem_housenumber.innerHTML = "";
    error_text_elem_gender.innerHTML = ""

    username_elem.classList.remove("input_error");
    password1_elem.classList.remove("input_error");
    password2_elem.classList.remove("input_error");
    email_elem.classList.remove("input_error");
    firstname_elem.classList.remove("input_error");
    lastname_elem.classList.remove("input_error");
    street_elem.classList.remove("input_error");
    city_elem.classList.remove("input_error");
    postcode_elem.classList.remove("input_error");
    country_elem.classList.remove("input_error");
    housenumber.classList.remove("input_error");
    gender.classList.remove("input_error");
}

function submitForm(){
    resetErrors();
    formObj = {
        username: username_elem.value,
        password1: password1_elem.value,
        password2: password2_elem.value,
        email: email_elem.value,
        firstname: firstname_elem.value,
        lastname: lastname_elem.value,
        street: street_elem.value,
        city: city_elem.value,
        postcode: postcode_elem.value,
        country: country_elem.value,
        housenumber: housenumber.value,
        gender: gender.value    
    }

    $.ajax({
        url : "/auth/register",
        type: "POST",
        data : formObj,
        success: function(data)
        {
            if(data != "0"){
                handleError(data);
                
            }else{
                window.location.href = "/login"
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

