const express = require('express')
const mysql_handler = require("./mysql_handler")
const bcrypt = require("bcryptjs")
const cookieParser = require("cookie-parser")
const jwt = require("jsonwebtoken")
const bodyParser = require("body-parser")
const app = express()
const port = 3000

const SECRET_KEY = "KEY"

app.set("view engine", "ejs")
app.use(express.json());
app.use(express.urlencoded({ extended: true}));
app.use(cookieParser());
app.use(bodyParser.json())
app.use(express.static(__dirname + "/static"));
/*
const authcookie = req.cookies.authcookie;

if(!authcookie){
    return false;
}

jwt.verify(authcookie, SECRET_KEY, (err, data) =>{
    if(err){
        return false;
    } else if(data.user){
        return true;
    }
})
*/

function authenticateHandler(req, res, next){
    const authcookie = req.cookies.authcookie;

    jwt.verify(authcookie, SECRET_KEY, (err, data) =>{
        if(err){
            console.log(err)
            res.redirect("/login")
        } else if(data.user){
            req.user = data.user;
            mysql_handler.con.query(`SELECT * FROM users WHERE id = "${req.user}"`, function(err, result){
                if(err) console.log(err);
                let user = JSON.parse(JSON.stringify(result))[0];
                req.isAdmin = user.isAdmin
                req.username = user.username
                req.firstname = user.firstname
                req.lastname = user.lastname
                next();
            });

            
        }
    })
}

app.get("/", authenticateHandler, (req, res) => {
    let dict = {
        title: "Hallo",
        isAdmin: req.isAdmin
    }

    res.render('index', dict)
})

app.get("/product/:productId", (req, res) => {
    let productId = req.params.productId;
    console.log(productId);
    
    mysql_handler.con.query(`SELECT * FROM products WHERE id=${productId}` , function(err, result){
        if(err) throw err;

        let product = JSON.parse(JSON.stringify(result))[0];
        let dict = {
            title: "product",
            product: product
        }
        res.render('product', dict)
    });
})

app.get("/search", (req, res) => {
    var products = [
        {
            title: "Panasonic LUMIX DC-GH5M2ME",
            price: 1699.99,
            img: "https://m.media-amazon.com/images/I/815eDw--FQS._AC_SL1500_.jpg",
            desc: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.",
        },
        {
            title: "Sony α 7 IV",
            price: 2999.00,
            img: "https://m.media-amazon.com/images/I/819+EOCsREL._AC_SL1500_.jpg",
            desc: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.",
        },
        {
            title: "Canon PowerShot G3 X",
            price: 876.34,
            img: "https://m.media-amazon.com/images/I/91bODLikNBL._AC_SL1500_.jpg",
            desc: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.",
        },
        {
            title: "Canon PowerShot SX710",
            price: 495.00,
            img: "https://m.media-amazon.com/images/I/91w6iw3JtiL._AC_SL1500_.jpg",
            desc: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.",
        },
    ]

    let dict = {
        title: "Suche",
        products: products
    }

    mysql_handler.con.query("SELECT * FROM products", function(err, result){
        if(err) throw err;

        dict.products = JSON.parse(JSON.stringify(result));
        
        res.render('search', dict)
    });
})
// Admin
app.get("/admin/product/delete/:productId", authenticateHandler, (req, res) => {
    if(req.isAdmin){
        productId = req.params.productId
        mysql_handler.con.query(`DELETE FROM products WHERE id=${productId}`, function(err, result){
            if(err) console.log(err);
        });
    }
})


// AUTH
app.get("/logout/", authenticateHandler, (req, res) => {
    res.clearCookie("authcookie")
    res.end()
})

app.get("/register/", (req, res) => {
    let dict = {
        title: "Register",
        error: ""
    }
    res.render('register', dict)    
})

app.get("/login/", (req, res) => {
    let dict = {
        title: "Login",
        error: ""
    }
    res.render('login', dict)    
})

app.get("/register/:error", (req, res) => {
    let dict = {
        title: "Register",
        error: req.params.error
    }
    res.render('register', dict)    
})

app.get("/login/:error", (req, res) => {
    let dict = {
        title: "Login",
        error: req.params.error
    }

    res.render('login', dict)    
})

app.post("/auth/register", (req, res) =>{
    let username = req.body.username;
    let email = req.body.email;
    let password1 = req.body.password1;
    let password2 = req.body.password2;
    let firstname = req.body.firstname;
    let lastname = req.body.lastname;
    let gender = req.body.gender;

    error = ""

    if(password1 != password2){
        error += "Passwörter sind unterschiedlich!";
    }else if(password1.length < 8){
        error += "Passwort muss mindestens 8 Zeichen lang sein!"
    }
    if(username.length < 3){
        error += "<br> Der Benutzername muss mindestens 3 Zeichen lang sein!"; 
    }else if(username.length > 30){
        error += "<br> Der Benutzername darf maximal 30 Zeichen lang sein!";
    }

    if(error != ""){
        res.redirect(`/register/${error}`)
    }else{
        bcrypt.genSalt(10, function(err, salt) {
            bcrypt.hash(password1, salt, function(err, hash){
                mysql_handler.createUser(username, email, hash, firstname, lastname, gender);
                res.redirect(`/login/`)
            })
        })
    }
})

app.post("/auth/login", (req, res) =>{
    let username = req.body.username;
    let password = req.body.password;

    error = ""
       
    mysql_handler.con.query(`SELECT * FROM users WHERE username = "${username}"`, function(err, result){
        if(err){
            error = "Login-Daten falsch!"
        }else{
            if(JSON.parse(JSON.stringify(result))[0]){
                user = JSON.parse(JSON.stringify(result))[0]
                dbPassword = user.password;
                

                bcrypt.compare(password, dbPassword, function(err, matched){
                    if(err) console.log(err);
                    if(matched){
                        // login
                        const token = jwt.sign({user:user.id}, SECRET_KEY)
                        res.cookie('authcookie', token, {maxAge: 900000, httpOnly: true})
                        res.redirect(`/`)
                    }else{
                        error = "Login-Daten falsch!"
                    }
                })
    
                
            }else{
                error = "Login-Daten falsch!"
            }
        }
    });
        
    if(error != ""){
        res.redirect(`/login/${error}`)
    }
})

app.listen(port, () =>{
    console.log("Listining to " + port)
})