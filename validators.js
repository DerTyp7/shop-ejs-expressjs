
function validate_password(password) {
    var re = /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}$/;

    if(re.test(password)){
        if(password.length > 8 && password.length < 255){
            return true
        }
    }
    return false;
}

module.exports = {
    validate_password
}