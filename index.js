const express = require('express')
const mysql_handler = require("./mysql_handler")
const bcrypt = require("bcryptjs")
const cookieParser = require("cookie-parser")
const jwt = require("jsonwebtoken")
const bodyParser = require("body-parser")
const app = express()
const uuid = require("uuid");
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

function authenticatedHandler(req, res, next){
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

function notAuthenticatedHandler(req, res, next){
    const authcookie = req.cookies.authcookie;

    jwt.verify(authcookie, SECRET_KEY, (err, data) =>{
        if(err){
            console.log(err)
            next(); 
        } else if(data.user){
            res.redirect("/")
                      
        }
    })
}

app.get("/", authenticatedHandler, (req, res) => {
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

// Order
app.get("/order/:productId/:quantity/", authenticatedHandler, (req, res) => {

    let error = ""
    mysql_handler.con.query(`SELECT * FROM products WHERE id=${req.params.productId}`, function(err, result){
        if(err) throw err;       
        result = JSON.parse(JSON.stringify(result))[0];

        if(req.params.quantity > result.quantity){
            error = "Nicht genug Produkte vorhanden"
        }

        let dict = {
            title: "Bestellung",
            error: error,
            product: result,
            quantity: req.params.quantity
        }

        res.render('order', dict)
    });   
})

app.get("/order_success/:trackingnumber", authenticatedHandler, (req, res) => {
    let dict = {
        title: "Bestellung erfolgreich",
        trackingnumber: req.params.trackingnumber
    }

    res.render('order_success', dict)
})
app.post("/order", authenticatedHandler, (req, res) => {
    let productId = req.body.productId;
    let quantity = req.body.quantity;
    let userId = req.user;

    mysql_handler.con.query(`SELECT * FROM products WHERE id=${productId}`, function(err, result){
        if(err) throw err;       
        result = JSON.parse(JSON.stringify(result))[0];

        if(quantity > result.quantity){
            res.redirect(`/order/${productId}/${quantity}/`)
        }else{
            order_trackingnumber = uuid.v4()
            mysql_handler.createOrder(userId, order_trackingnumber, 0, productId, quantity)    
    
            res.redirect("/order_success/" + order_trackingnumber)
        }        
    });
})


// Admin
app.get("/admin/product/delete/:productId", authenticatedHandler, (req, res) => {
    if(req.isAdmin){
        productId = req.params.productId
        mysql_handler.con.query(`DELETE FROM products WHERE id=${productId}`, function(err, result){
            if(err) console.log(err);
        });
    }
})

// AUTH
app.get("/logout/", authenticatedHandler, (req, res) => {
    res.clearCookie("authcookie")
    res.redirect("/")
})

app.get("/register/:error?", notAuthenticatedHandler, (req, res) => {
    let dict = {
        title: "Register",
        error: req.params.error
    }
    res.render('register', dict)    
})

app.get("/login/:error?", notAuthenticatedHandler, (req, res) => {
    let dict = {
        title: "Login",
        error: req.params.error
    }

    res.render('login', dict)    
})

app.post("/auth/register", notAuthenticatedHandler,(req, res) =>{
    let username = req.body.username;
    let email = req.body.email;
    let password1 = req.body.password1;
    let password2 = req.body.password2;
    let firstname = req.body.firstname;
    let lastname = req.body.lastname;
    let gender = req.body.gender;
    let street = req.body.street;
    let housenumber = req.body.housenumber;
    let postcode = req.body.postcode;
    let cityName = req.body.cityName;
    let country = req.body.country;

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
                mysql_handler.createUser(username, email, hash, firstname, lastname, gender, street, housenumber, postcode, cityName, country);
                 
                res.redirect(`/login/`)             
            })
        })
    }
})

app.post("/auth/login", notAuthenticatedHandler, (req, res) =>{
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
                        res.cookie('authcookie', token, {maxAge: 90000000, httpOnly: true})
                        res.redirect(`/`)
                    }else{
                        error = "Login-Daten falsch!"
                    }
                })
    
                
            }else{
                error = "Login-Daten falsch!"
            }
        }
        if(error != ""){
            res.redirect(`/login/${error}`)
        }
    });
})

app.listen(port, () =>{
    console.log("Listining to " + port)
})