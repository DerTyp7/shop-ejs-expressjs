// Import Packages
const express = require('express');
const bcrypt = require("bcryptjs");
const cookieParser = require("cookie-parser");
const jwt = require("jsonwebtoken");
const bodyParser = require("body-parser");
const uuid = require("uuid");

// Import Modules
const mysql_handler = require("./mysql_handler");
const validators = require("./validators")

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

    if(authcookie){
        jwt.verify(authcookie, SECRET_KEY, (err, data) =>{  // Verify authcookie
            if(err){ // If authcookie is invalid
                console.log(err);
                req.user = false;
                next();
            } else if(data.user){ // If authcookie is valid
                req.user = data.user; // Set user to data.user
                mysql_handler.con.query(`SELECT * FROM users WHERE id = "${req.user}"`, (err, result) => { // Get user from database

                    if(err) console.log(err);
                    let user = JSON.parse(JSON.stringify(result))[0]; // Parse user from database
                    if(result.length > 0){
                        // Set user to req.user
                        req.isAdmin = user.isAdmin;
                        req.username = user.username;
                        req.firstname = user.firstname;
                        req.lastname = user.lastname;
                        req.email = user.email;
                    }
                    next(); // Continue to next handler
                });
            }
        });
    }else{
        console.log("No Redirect: Not autheticated")
        req.user = false;
        next();
    }
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
            mysql_handler.con.query(`SELECT * FROM users LEFT JOIN userinfos ON users.id=userinfos.userId WHERE users.id = "${req.user}"`, (err, result) => { // Get user from database
                if(err) console.log(err);
                if(result.length > 0){
                    let user = JSON.parse(JSON.stringify(result))[0]; // Parse user from database
                    // Set user to req.user
                    req.isAdmin = user.isAdmin;
                    req.username = user.username;
                    req.firstname = user.firstname;
                    req.lastname = user.lastname;
                    req.email = user.email;
                    
                }
                next(); // Continue to next handler
            });
        }
    });
}

// Check if user is not authenticated and redirect to home if so
function notAuthenticatedHandler(req, res, next){ 
    const authcookie = req.cookies.authcookie; // Get authcookie from cookie

    if(authcookie){
        jwt.verify(authcookie, SECRET_KEY, (err, data) =>{ // Verify authcookie
            if(err){ // If authcookie is invalid
                console.log(err);
                next(); // Continue to next handler
            } else if(data.user){ // If authcookie is valid
                res.redirect("/");      
            }
        });
    }else{
        next();
    }
    
}

// Homepage
app.get("/", authNoRedirectHandler, (req, res) => { 

    mysql_handler.con.query("SELECT * FROM products", function(err, result){
        if(err) throw err;
        let products = JSON.parse(JSON.stringify(result));

        mysql_handler.con.query("SELECT * FROM product_images", function(err, result){
            if(err) throw err;
            let dict = {
                title: "Startseite",
                user: req.user,
                products: products,
                product_images: JSON.parse(JSON.stringify(result)),
            }
            res.render('index', dict)
        })
    });
});
app.get("/productImage/:productId", (req,res) => {
    mysql_handler.con.query(`SELECT url FROM product_images WHERE product_id = ${req.params.productId} `,(err,result) =>{
        if (result.length > 0){
            res.redirect(JSON.parse(JSON.stringify(result))[0].url)
        }
        else {
            res.redirect("/images/examples.jpg")
        }
    })
})

// Account
app.get("/account", authenticatedHandler, (req, res) => { 
    mysql_handler.con.query(`SELECT orders.id, products.name, order_products.quantity, order_products.price
    FROM orders LEFT JOIN order_products ON orders.id=order_products.orderId
    LEFT JOIN products ON order_products.productId=products.id WHERE orders.userId = '${req.user}' ORDER BY orders.id DESC`, (err, result) => {
        if(err) console.log(err);
        let orders = JSON.parse(JSON.stringify(result))

        mysql_handler.con.query(`SELECT * FROM addresses LEFT JOIN cities ON addresses.cityId=cities.id WHERE addresses.userId=${req.user}`, (err, result) =>{
            if(err) console.log(err);
            
            let dict = {
                title: "Account",
                user: req.user,
                isAdmin: req.isAdmin,
                username: req.username,
                firstname: req.firstname,
                lastname: req.lastname,
                email: req.email,
                orders: orders,
                address: JSON.parse(JSON.stringify(result))[0],
            }

            res.render('account', dict)
       });
    })
});


// Product Page
app.get("/product/:productId", authNoRedirectHandler, (req, res) => {
    let productId = req.params.productId;
    
    mysql_handler.con.query(`SELECT s.name AS sellerName, p.name AS productName, p.description AS productDescription, p.id AS id, price,quantity, delivery_time
     FROM products AS p LEFT JOIN  sellers AS s ON p.sellerId= s.id WHERE p.id=${productId}` , function(err, result){
        if(err) throw err;

        let product = JSON.parse(JSON.stringify(result))[0];
        
        mysql_handler.con.query(`SELECT title, content ,rating, u.username AS name FROM reviews AS r LEFT JOIN users AS u ON r.userId = u.id WHERE productId=${productId}`,function(err,result){
            if(err) throw err;
            let reviews = JSON.parse(JSON.stringify(result));

            mysql_handler.con.query(`SELECT * FROM categories WHERE id IN (SELECT category_id FROM product_categories WHERE product_id = ${product.id})`,function(err,result){
                if(err) throw err;
                let categories = JSON.parse(JSON.stringify(result));

                mysql_handler.con.query(`SELECT url FROM product_images WHERE product_id = ${product.id};`,function(err,result){
                    if(err) throw err;
                    let images = JSON.parse(JSON.stringify(result));

                    let dict = {
                        title: product.productName,
                        product: product,
                        shippingDays: 3,
                        stockAmount: 50,
                        productDescription: "ez",
                        loggedIn: true,
                        reviews: reviews,
                        categories: categories, 
                        images: images, 
                        user: req.user,                   
                    }
                    res.render('product', dict)
                });
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
app.get("/search/:query/",authNoRedirectHandler,(req, res) => {
    let query = req.params.query;
    let dict = {
        title: "Suche",
        search: query,
        user: req.user, 
        sort: req.query.sort ? req.query.sort : 0,
        Cat: req.query.cat ? req.query.cat : 0,
        Brand: req.query.brand ? req.query.brand : 0
    }

    mysql_handler.con.query("SELECT * FROM categories;",function(err, result) {
        if(err) throw err;

        dict.categories = JSON.parse(JSON.stringify(result));
    });
    mysql_handler.con.query("SELECT * FROM sellers;",function(err, result) {
        if(err) throw err;

        dict.brands = JSON.parse(JSON.stringify(result));
    });

    var catQuery = "";
    var cat = req.query.cat;
    if (typeof cat !== 'undefined' && cat != 0) {
        catQuery = " AND (SELECT COUNT(*) FROM product_categories c WHERE c.category_id = "+cat+" AND c.product_id = p.id)";
    }
    var brandQuery = "";
    var brand = req.query.brand;
    if (typeof brand !== 'undefined' && brand != 0) {
        brandQuery = " AND p.sellerid = "+brand;
    }

    var sortQuery = "";
    var sort = req.query.sort;
    if (typeof sort !== 'undefined') {
        if (sort == 1) {
            sortQuery = " ORDER BY price ASC";
        } else if (sort == 2) {
            sortQuery = " ORDER BY price DESC";
        } else if (sort == 3) {
            sortQuery = " ORDER BY (SELECT SUM(quantity) FROM order_products o WHERE o.productId = p.id) DESC";
        } else if (sort == 4) {
            sortQuery = " ORDER BY name ASC";
        } else if (sort == 5) {
            sortQuery = " ORDER BY name DESC";
        }
    }
    
    mysql_handler.con.query("SELECT *, (SELECT url FROM product_images i WHERE i.product_id = p.id LIMIT 1) as img, (SELECT AVG(rating) FROM reviews r WHERE r.productId = p.id) as rating FROM products p WHERE p.name LIKE ? OR p.id IN (SELECT pc.product_id FROM categories c, product_categories pc WHERE c.id = pc.category_id AND c.name LIKE ?) "+catQuery+" "+brandQuery+" "+sortQuery+";",["%"+query+"%","%"+query+"%"],function(err, result){
        if(err) throw err;

        dict.products = JSON.parse(JSON.stringify(result));
        
        res.render('search', dict)
    });
})


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
            quantity: req.params.quantity,
            user: req.user,     
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
app.post("/auth/register", notAuthenticatedHandler, (req, res) =>{
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
    let city = req.body.city;
    let country = req.body.country;

    let error = false;
    /*
    0: No error
    error_username_duplicate: Username already exists
    error_email_duplicate: Email already exists
    error_password_length_short: Password is too short
    error_password_length_long: Password is too long
    error_password_mismatch: Passwords do not match
    error_password_invalid
    error_email_invalid
    error_username_invalid
    error_firstname_invalid
    error_lastname_invalid
    error_street_invalid
    error_housenumber_invalid
    error_postcode_invalid
    error_cityname_invalid
    error_country_invalid
    */

    validateUsername = validators.validate_username(username);
    if(validateUsername != 0){
        console.log(validateUsername);
        res.send(validateUsername);
        return;
    }
    
    
    validateEmail = validators.validate_email(email);
    if(validateEmail != 0){     
        console.log(validateEmail);
        res.send(validateEmail);
        return;
    }

   
    
    validatePasswords = validators.validate_passwords(password1, password2);
    if(validatePasswords != 0){
        console.log(validatePasswords);
        res.send(validatePasswords);
        return;
    }

    validateFirstname = validators.validate_firstname(firstname);
    if(validateFirstname != 0){
        console.log(validateFirstname);
        res.send(validateFirstname);
        return;
    }

    validateLastname = validators.validate_lastname(lastname);
    if(validateLastname != 0){
        console.log(validateLastname);
        res.send(validateLastname);
        return;
    }

    validateGender = validators.validate_gender(gender);
    if(validateGender != 0){
        console.log(validateGender);
        res.send(validateGender);
        return;
    }

    validateStreet = validators.validate_street(street);
    if(validateStreet != 0){
        console.log(validateStreet);
        res.send(validateStreet);
        return;
    }

    validateHousenumber = validators.validate_housenumber(housenumber);
    if(validateHousenumber != 0){
        console.log(validateHousenumber);
        res.send(validateHousenumber);
        return;
    }

    validatePostcode = validators.validate_postcode(postcode);
    if(validatePostcode != 0){
        console.log(validatePostcode);
        res.send(validatePostcode);
        return;
    }

    validateCity = validators.validate_city(city);
    if(validateCity != 0){
        console.log(validateCity);
        res.send(validateCity);
        return;
    }

    validateCountry = validators.validate_country(country);
    if(validateCountry != 0){
        console.log(validateCountry);
        res.send(validateCountry);
        return;
    }

    



     // CHECK DUPLICATES
    // Check email duplicate
    mysql_handler.con.query(`SELECT * FROM users WHERE email='${email}'`, (err, result) => {
        if(err) console.log(err);
        if(result.length > 0){
            res.send("error_email_duplicate");
        }else{

        
            // Check username duplicate
            mysql_handler.con.query(`SELECT * FROM users WHERE username='${username}'`, (err, result) => {
                if(err) console.log(err);
                if(result.length > 0){
                    res.send("error_username_duplicate");
                }else{
                    // NO duplicates
                    bcrypt.genSalt(10, function(err, salt) { // Generate salt
                        bcrypt.hash(password1, salt, function(err, hash){ // Hash password
                            console.log("create");
                            mysql_handler.createUser(username, email, hash, firstname, lastname, gender, street, housenumber, postcode, city, country);
                            res.send("0");      
                        });
                    });
                }
            })
        }
    });    
});

// Login POST Request
app.post("/auth/login", notAuthenticatedHandler, (req, res) =>{
    // Get data from POST request
    let username = req.body.username;
    let password = req.body.password;

    let error = "" // Error message
       
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