function validate_housenumber(housenumber){

    if(!housenumber){
        return "error_housenumber_invalid";
    }

    if(housenumber.length < 1){
        return "error_housenumber_short";
    }

    if(housenumber.length > 20){
        return "error_housenumber_long";
    }

    if(!housenumber.match(/^[0-9]*$/)){
        return "error_housenumber_invalid";
    }

    return 0;
}

function validate_postcode(postcode){

    if(!postcode){
        return "error_postcode_invalid";
    }

    if(postcode.length < 1){
        return "error_postcode_short";
    }

    if(postcode.length > 20){
        return "error_postcode_long";
    }

    if(!postcode.match(/^[0-9]*$/)){
        return "error_postcode_invalid";
    }

    return 0;
}


function validate_country(country){

    if(!country){
        return "error_country_invalid";
    }

    if(country.length < 1){
        return "error_country_short";
    }

    if(country.length > 80){
        return "error_country_long";
    }

    if(!country.match(/^[a-zA-Zßäöü-\s]*$/)){
        return "error_country_invalid";
    }

    return 0;
}

function validate_city(city){

    if(!city){
        return "error_city_invalid";
    }

    if(city.length < 1){
        return "error_city_short";
    }

    if(city.length > 80){
        return "error_city_long";
    }

    if(!city.match(/^[a-zA-Zßäöü-\s]*$/)){
        return "error_city_invalid";
    }

    return 0;
}

function validate_street(street){

    if(!street){
        return "error_street_invalid";
    }

    if(street.length < 1){
        return "error_street_short";
    }

    if(street.length > 80){
        return "error_street_long";
    }

    if(!street.match(/^[a-zA-Zßäöü.-\s]*$/)){
        return "error_street_invalid";
    }

    return 0;
}

function validate_gender(gender){

    if(!gender){
        return "error_gender_invalid";
    }

    if(gender.length < 1){
        return "error_gender_short";
    }

    if(gender.length > 15){
        return "error_gender_long";
    }

    if(!gender.match(/^[a-zA-Z0-9ßäöü.-\s]*$/)){
        return "error_gender_invalid";
    }

    return 0;
}

function validate_lastname(lastname){
    
    if(!lastname){
        return "error_lastname_invalid"     
    }

    if(lastname.length < 1){
        return "error_lastname_short";
    }

    if(lastname.length > 80){
        return "error_lastname_long";
    }

    if(!lastname.match(/^[a-zA-Z0-9ßäöü-]*$/)){
        return "error_lastname_invalid";
    }

    return 0;
}

function validate_username(username){
    
    if(!username){
        return "error_username_invalid";
    }

    if(username.length < 3){
        return "error_username_short";
    }

    if(username.length > 30){
        return "error_username_long";
    }

    if(!username.match(/^[a-zA-Z0-9_]*$/)){
        return "error_username_invalid";
    }

    return 0;
}

function validate_firstname(firstname){
    if(!firstname){
        return "error_firstname_invalid2";
    }

    if(firstname.length < 1){
        return "error_firstname_length_short";
    }

    if(firstname.length > 80){
        return "error_firstname_length_long";
    }

    if(!firstname.match(/^[a-zA-Z0-9ßäöü]*$/)){
        return "error_firstname_invalid";
    }

    return 0;
}

function validate_email(email){
    if(!email){
        return "error_email_invalid";
    }

    if(email.length < 3 || !email.includes("@") || !email.includes(".")){
        return "error_email_invalid"
    } 

    return 0;
    
}

function validate_passwords(password, confirm_password) {
    const maxLength = 200;
    const minLength = 8;

    if(!password){
        return "error_password_invalid"
    }

    if(password.length < minLength){
        return "error_password_short"
    }

    if(password.length > maxLength){
        return "error_password_long"
    }

    // check password for invalid character
    if(!password.match(/^[a-zA-Z0-9!@#$%^&*.,;:]*$/)){
        return "error_password_invalid"
    }

    if(password != confirm_password){
        return "error_password_mismatch"
    }


    return 0;
}

module.exports = {
    validate_passwords, validate_email , validate_username, validate_firstname,
     validate_lastname, validate_gender, validate_street, validate_country, validate_city, validate_postcode, validate_housenumber
}