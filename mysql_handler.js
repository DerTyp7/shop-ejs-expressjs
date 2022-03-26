let mysql = require('mysql')
let connected = false;

// TODO check here for errors and do not let the db throw an error in order to give the user feedback 

/*
con.query("SELECT * FROM users", function(err, result){
    if(err) throw err;
    } 
    console.log(result);
});

*/
let con = mysql.createConnection({
    host: "localhost",
    user: "onlineshop",
    password: "TestUser321",
    database: "onlineshop"
});

con.connect(function(err){
    if(err) throw err;
    console.log("Connected to MySQL!");
    connected = true
    //createUser("dertyp", "address@email.com", "password", "Janis", "Meister", "Herr");
    //createAddress("street", "1", "postcode", "city", "country", 18)
    //createSeller("TEST", "test")
    //createProduct("name", 1.2, "description", 2, 2, 1, 1)
    //createReview("TESt", "Content", 6, 18, 1)
    //createOrder(18, "tasddadse");
    //createOrderProduct(1.5, 5, 1, 1)
})

function isConnected(){
    if(connected){
        return true;
    }else{
        console.log("not connected to mysql")
        return false;
    }
}

function sendQuery(sql){
    if(isConnected){
        con.query(sql, function(err, result){
            if(err){
                console.log(err);
                return false;
            } 
            return result;
        });
    }
}

// CREATES
function createOrder(userId, trackingnumber, received = 0){
    createOrderStatus(trackingnumber);

    sendQuery(`INSERT INTO orders(userId, order_statusId)
    VALUES ((SELECT id FROM users WHERE id='${userId}'), (SELECT id FROM order_status WHERE trackingnumber='${trackingnumber}'))`);
}

function createOrderProduct(price, quantity, productId, orderId){
    r = sendQuery(`INSERT INTO order_products(price, quantity, productId, orderId)
    VALUES ('${price}','${quantity}',
    (SELECT id FROM products WHERE id='${productId}'), (SELECT id FROM orders WHERE id='${orderId}'))`);
}

function createOrderStatus(trackingnumber, received = 0){
    sendQuery(`INSERT INTO order_status(received, trackingnumber) VALUES (${received}, '${trackingnumber}')`); 
}

function createReview(title, content, rating, userID, productId){
    sendQuery(`INSERT INTO reviews(title, content, rating, userID, productId)
    VALUES ('${title}','${content}','${rating}',
    (SELECT id FROM users WHERE id='${userID}'), (SELECT id FROM products WHERE id='${productId}'))`);
    
}

function createProduct(name, price, description, quantity, delivery_time, sellerId, categoryId){
    sendQuery(`INSERT INTO products(name, price, description, quantity, delivery_time, sellerId, categoryId)
     VALUES ('${name}',${price},'${description}','${quantity}','${delivery_time}',
    (SELECT id FROM sellers WHERE id='${sellerId}'), (SELECT id FROM categories WHERE id='${categoryId}'))`);
}

function createCategory(name){
    sendQuery(`INSERT INTO categories(name) VALUES ('${name}')`); 
}

function createSeller(name, description){
    sendQuery(`INSERT INTO sellers(name, description) VALUES ('${name}', '${description}')`); 
}

function createUser(username, email, password, firstname, lastname, gender){
    result = sendQuery(`INSERT INTO users(username, email, password) VALUES ('${username}','${email}','${password}')`); 
    if(result){
        sendQuery(`INSERT INTO userinfos(firstname, lastname, gender, userId) VALUES ('${firstname}','${lastname}','${gender}',
        (SELECT id FROM users WHERE username='${username}' AND email='${email}'))`);
        console.log(`User created: ${username}!`)
    }       
}

function createAddress(street, housenumber, postcode, city, country, userId){
    sendQuery(`INSERT INTO addresses(street, housenumber, postcode, city, country, userId) VALUES ('${street}','${housenumber}','${postcode}','${city}','${country}',
    (SELECT id FROM users WHERE id='${userId}'))`);   
}



module.exports = {
    sendQuery, createOrder, createOrderProduct, createOrderStatus, createReview,
    createProduct, createCategory, createSeller, createUser, createAddress, con
}
