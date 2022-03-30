const mysql = require('mysql')

// TODO check here for errors and do not let the db throw an error in order to give the user feedback 

/*
con.query("SELECT * FROM users", function(err, result){
    if(err) throw err;
    } 
    console.log(result);
});
*/

let con = mysql.createConnection({ // TODO: change to config file
    host: "localhost",
    user: "root",
    password: "", // TODO: DO NOT STORE PASSWORDS IN THE CODE
    database: "onlineshop"
});

con.connect(function(err){ // Connect to the database
    if(err) throw err;
    console.log("Connected to MySQL!");
})

function isConnected(){ 
    // Check if database is connected
    if(con.state === 'disconnected'){
        return false;
    }
    return true;
}

// Create Order database structure
function createOrder(userId, trackingnumber, received, productId, quantity){ // TODO: add date
     // create order status
    con.query(`INSERT INTO order_status(received, trackingnumber) VALUES (${received}, '${trackingnumber}')`, (err, result) => {
        if(err) console.log(err);

        // create order
        con.query(`INSERT INTO orders(userId, order_statusId) VALUES ((SELECT id FROM users WHERE id='${userId}'),
         (SELECT id FROM order_status WHERE trackingnumber='${trackingnumber}'))`, function(err, result){
            
            // create order_product
            con.query(`SELECT orders.id FROM orders LEFT JOIN order_status ON orders.order_statusId=order_status.id WHERE order_status.trackingnumber='${order_trackingnumber}'`, function(err, result){
                if(err) console.log(err);
                order = JSON.parse(JSON.stringify(result))[0]; // parse result to json
                if(order != undefined){  // if order is not undefined
                    con.query(`SELECT * FROM products WHERE id=${productId}`, (err, result) => { // get product
                        if(err) console.log(err);

                        product = JSON.parse(JSON.stringify(result))[0]; // parse result to json
                        
                        // update old product quantity
                        con.query(`UPDATE products SET quantity=quantity-${quantity} WHERE id=${productId}`, (err, result) => { 
                            // create order_product
                            con.query(`INSERT INTO order_products(price, quantity, productId, orderId)
                            VALUES ('${product.price}','${quantity}',
                            (SELECT id FROM products WHERE id='${product.id}'), (SELECT id FROM orders WHERE id='${order.id}'))`, (err, result) => {
                                if(err) console.log(err);
                            });
                        });
                    });
                }
            });
        });
    });    
}

// Create Review
function createReview(title, content, rating, userID, productId){ // TODO: add date
    con.query(`INSERT INTO reviews(title, content, rating, userID, productId)
    VALUES ('${title}','${content}','${rating}',
    (SELECT id FROM users WHERE id='${userID}'), (SELECT id FROM products WHERE id='${productId}'))`, (err, result) => {
        if(err) console.log(err);
    });    
}

// Create Product
function createProduct(name, price, description, quantity, delivery_time, sellerId, categoryId){
    con.query(`INSERT INTO products(name, price, description, quantity, delivery_time, sellerId, categoryId)
    VALUES ('${name}',${price},'${description}','${quantity}','${delivery_time}',
   (SELECT id FROM sellers WHERE id='${sellerId}'), (SELECT id FROM categories WHERE id='${categoryId}'))`, (err, result) => {
        if(err) console.log(err);
    });
}

// Create User database structure
function createUser(username, email, password, firstname, lastname, gender, street, housenumber, postcode, cityName, country){ // TODO: Better error handling if something goes wrong in progress
    // Create User
    con.query(`INSERT INTO users(username, email, password) VALUES ('${username}','${email}','${password}')`, (err, result) =>{
        if(err){
            console.log(err);
        }else if(result){
            // Create User Info
            con.query(`INSERT INTO userinfos(firstname, lastname, gender, userId) VALUES ('${firstname}','${lastname}','${gender}',
            (SELECT id FROM users WHERE username='${username}' AND email='${email}'))`, (err, result) => {
                if(err) console.log(err);
            });
            
            // Create City
            con.query(`INSERT INTO cities(name, postcode) VALUES ('${cityName}', '${postcode}')`, (err, result) => {
                if(err) console.log(err);
            });
            
            // Create Address
            con.query(`INSERT INTO addresses(street, housenumber, country, userId, cityId) VALUES ('${street}','${housenumber}','${country}',
            (SELECT id FROM users WHERE username='${username}'), (SELECT id FROM cities WHERE name='${cityName}' AND postcode='${postcode}'))`, (err, result) => { 
                if(err) console.log(err);
            });
            
            console.log(`User created: ${username}!`);
        }
    });
}



module.exports = {
    createOrder, createReview, isConnected,
    createProduct, createUser, con
}
