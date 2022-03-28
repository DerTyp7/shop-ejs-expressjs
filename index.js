// Import Packages
const express = require('express');
const bcrypt = require("bcryptjs");
const cookieParser = require("cookie-parser");
const jwt = require("jsonwebtoken");
const bodyParser = require("body-parser");
const uuid = require("uuid");

// Import Modules
const mysql_handler = require("./mysql_handler");

// Global Variables
const app = express();
const port = 3000;
const SECRET_KEY = "KEY";

// Express App Setup
app.set("view engine", "ejs");
app.use(express.json());
app.use(express.urlencoded({ extended: true}));
app.use(cookieParser());
app.use(bodyParser.json());
app.use(express.static(__dirname + "/static"));

// Authentication Handlers

// Check if user is authenticated and NO redirect
function authNoRedirectHandler(req, res, next){
    const authcookie = req.cookies.authcookie; // Get authcookie from cookie

    jwt.verify(authcookie, SECRET_KEY, (err, data) =>{  // Verify authcookie
        if(err){ // If authcookie is invalid
            console.log(err);
            next();
        } else if(data.user){ // If authcookie is valid
            req.user = data.user; // Set user to data.user
            mysql_handler.con.query(`SELECT * FROM users WHERE id = "${req.user}"`, (err, result) => { // Get user from database
                if(err) console.log(err);
                let user = JSON.parse(JSON.stringify(result))[0]; // Parse user from database
                // Set user to req.user
                req.isAdmin = user.isAdmin;
                req.username = user.username;
                req.firstname = user.firstname;
                req.lastname = user.lastname;
                next(); // Continue to next handler
            });
        }
    });
}


// Check if user is authenticated and redirect to login if not
function authenticatedHandler(req, res, next){
    const authcookie = req.cookies.authcookie; // Get authcookie from cookie

    jwt.verify(authcookie, SECRET_KEY, (err, data) =>{  // Verify authcookie
        if(err){ // If authcookie is invalid
            console.log(err);
            res.redirect("/login");
        } else if(data.user){ // If authcookie is valid
            req.user = data.user; // Set user to data.user
            mysql_handler.con.query(`SELECT * FROM users WHERE id = "${req.user}"`, (err, result) => { // Get user from database
                if(err) console.log(err);
                let user = JSON.parse(JSON.stringify(result))[0]; // Parse user from database
                // Set user to req.user
                req.isAdmin = user.isAdmin;
                req.username = user.username;
                req.firstname = user.firstname;
                req.lastname = user.lastname;
                next(); // Continue to next handler
            });
        }
    });
}

// Check if user is not authenticated and redirect to home if so
function notAuthenticatedHandler(req, res, next){ 
    const authcookie = req.cookies.authcookie; // Get authcookie from cookie

    jwt.verify(authcookie, SECRET_KEY, (err, data) =>{ // Verify authcookie
        if(err){ // If authcookie is invalid
            console.log(err);
            next(); // Continue to next handler
        } else if(data.user){ // If authcookie is valid
            res.redirect("/");      
        }
    });
}

// Homepage
app.get("/", authNoRedirectHandler, (req, res) => { 
    mysql_handler.con.query("SELECT * FROM products", function(err, result){
        if(err) throw err;

        let dict = {
            title: "Startseite",
            user: req.user,
            products: JSON.parse(JSON.stringify(result))
        }
        res.render('index', dict)
    });
});

// Product Page
app.get("/product/:productId", (req, res) => {
    let productId = req.params.productId;
    
    mysql_handler.con.query(`SELECT s.name AS sellerName, p.name AS productName, p.description AS productDescription, p.id AS id, price,quantity, delivery_time, p.categoryId
     FROM products AS p LEFT JOIN  sellers AS s ON p.sellerId= s.id WHERE p.id=${productId}` , function(err, result){
        if(err) throw err;

        let product = JSON.parse(JSON.stringify(result))[0];
        
        mysql_handler.con.query(`SELECT title, content ,rating, u.username AS name FROM reviews AS r LEFT JOIN users AS u ON r.userId = u.id WHERE productId=${productId}`,function(err,result){
            if(err) throw err;
            let reviews = JSON.parse(JSON.stringify(result));
            console.log(product)
            mysql_handler.con.query(`SELECT * FROM categories WHERE id='${product.categoryId}'`,function(err,result){
                if(err) throw err;
                let category = JSON.parse(JSON.stringify(result))[0];

                let dict = {
                    title: product.productName,
                    product: product,
                    shippingDays: 3,
                    stockAmount: 50,
                    productDescription: "ez",
                    loggedIn: true,
                    reviews: reviews,
                    category: category,                    
                }
                res.render('product', dict)
            });
        });
        
    });
});

// Reviews
app.post("/review/create/:productId", authenticatedHandler,(req, res) => {
    let productId = req.params.productId;
    let rating = req.body.rating;
    let title = req.body.title;
    let content = req.body.content;
    

    mysql_handler.con.query(`INSERT INTO reviews(title, content, rating, userId, productId)
     VALUES('${title}', '${content}', '${rating}', (SELECT id FROM users WHERE id = ${req.user}), (SELECT id FROM products WHERE id = ${productId}))`, (err, result) => {
        if(err) throw err;
        res.redirect("/product/" + productId);
    });

});

// Search Page
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
});

// Order Page
app.get("/order/:productId/:quantity/", authenticatedHandler, (req, res) => {

    let error = "";
    mysql_handler.con.query(`SELECT * FROM products WHERE id=${req.params.productId}`, function(err, result){ // Get product from database
        if(err) throw err;       

        result = JSON.parse(JSON.stringify(result))[0]; // Parse result from database

        if(req.params.quantity > result.quantity){ // If quantity is higher than available quantity
            error = "Nicht genug Produkte vorhanden";
        }

        let dict = {
            title: "Bestellung",
            error: error,
            product: result,
            quantity: req.params.quantity
        }

        res.render('order', dict);
    });   
});

// Order Success Page
app.get("/order_success/:trackingnumber", authenticatedHandler, (req, res) => {
    let dict = {
        title: "Bestellung erfolgreich",
        trackingnumber: req.params.trackingnumber
    }

    res.render('order_success', dict);
});

// Order POST Request
app.post("/order", authenticatedHandler, (req, res) => {
    let productId = req.body.productId;
    let quantity = req.body.quantity;
    let userId = req.user;

    mysql_handler.con.query(`SELECT * FROM products WHERE id=${productId}`, function(err, result){
        if(err) throw err;       
        result = JSON.parse(JSON.stringify(result))[0];

        if(quantity > result.quantity){
            res.redirect(`/order/${productId}/${quantity}/`);
        }else{
            order_trackingnumber = uuid.v4();
            mysql_handler.createOrder(userId, order_trackingnumber, 0, productId, quantity) ;   
    
            res.redirect("/order_success/" + order_trackingnumber);
        }        
    });
});


// Admin
app.get("/admin/product/delete/:productId", authenticatedHandler, (req, res) => {
    if(req.isAdmin){
        productId = req.params.productId;
        mysql_handler.con.query(`DELETE FROM products WHERE id=${productId}`, function(err, result){
            if(err) console.log(err);
        });
    }
});

// Authentication
// Logout
app.get("/logout/", authenticatedHandler, (req, res) => {
    res.clearCookie("authcookie"); // Clear cookie
    res.redirect("/");
});

// Register Page
app.get("/register/:error?", notAuthenticatedHandler, (req, res) => {
    let dict = {
        title: "Register",
        error: req.params.error
    }
    res.render('register', dict); 
});

// Login Page
app.get("/login/:error?", notAuthenticatedHandler, (req, res) => {
    let dict = {
        title: "Login",
        error: req.params.error
    }

    res.render('login', dict);
});

// Register POST Request
app.post("/auth/register", notAuthenticatedHandler,(req, res) =>{
    // Get data from POST request
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

    let error = ""; // Error message

    if(password1 != password2){ // If passwords don't match
        error += "Passwörter sind unterschiedlich!";
    }else if(password1.length < 8){ // If password is too short
        error += "Passwort muss mindestens 8 Zeichen lang sein!";
    }
    if(username.length < 3){ // If username is too short
        error += "<br> Der Benutzername muss mindestens 3 Zeichen lang sein!"; 
    }else if(username.length > 30){ // If username is too long
        error += "<br> Der Benutzername darf maximal 30 Zeichen lang sein!";
    }

    if(error != ""){ // If there is an error
        res.redirect(`/register/${error}`); // Redirect to register page with error message
    }else{
        bcrypt.genSalt(10, function(err, salt) { // Generate salt
            bcrypt.hash(password1, salt, function(err, hash){ // Hash password
                mysql_handler.createUser(username, email, hash, firstname, lastname, gender, street, housenumber, postcode, cityName, country);
                res.redirect(`/login/`);        
            });
        });
    }
});

// Login POST Request
app.post("/auth/login", notAuthenticatedHandler, (req, res) =>{
    // Get data from POST request
    let username = req.body.username;
    let password = req.body.password;

    error = "" // Error message
       
    mysql_handler.con.query(`SELECT * FROM users WHERE username = "${username}"`, function(err, result){ // Get user from database
        if(err){ // If there is an error
            error = "Login-Daten falsch!"
        }else{ // If there is no error
            result = JSON.parse(JSON.stringify(result))[0]; // Parse result from database
            if(result){ // If there is a user
                user = result; // Set user
                dbPassword = user.password; // Get password from database
                
                bcrypt.compare(password, dbPassword, function(err, matched){ // Compare password
                    if(err) console.log(err);
                    if(matched){ // If password matches
                        // Set cookie
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
        if(error != ""){ // If there is an error
            res.redirect(`/login/${error}`)
        }
    });
})

app.listen(port, () =>{ // Start server
    console.log("Listining to " + port)
});