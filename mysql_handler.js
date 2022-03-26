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
function createOrder(userId, trackingnumber, received, productId, quantity){
    con.query(`INSERT INTO order_status(received, trackingnumber) VALUES (${received}, '${trackingnumber}')`, function(err, result){
        if(err) console.log(err);

        con.query(`INSERT INTO orders(userId, order_statusId)
        VALUES ((SELECT id FROM users WHERE id='${userId}'), (SELECT id FROM order_status WHERE trackingnumber='${trackingnumber}'))`, function(err, result){
            
            con.query(`SELECT orders.id FROM orders LEFT JOIN order_status ON orders.order_statusId=order_status.id WHERE order_status.trackingnumber='${order_trackingnumber}'`, function(err, result){
                if(err) console.log(err);
                order = JSON.parse(JSON.stringify(result))[0];

                con.query(`SELECT * FROM products WHERE id=${productId}`, (err, result) => {
                    if(err) console.log(err);
                    product = JSON.parse(JSON.stringify(result))[0];
                    
                    con.query(`UPDATE products SET quantity=quantity-${quantity} WHERE id=${productId}`, (err, result) => {
                        con.query(`INSERT INTO order_products(price, quantity, productId, orderId)
                        VALUES ('${product.price}','${quantity}',
                        (SELECT id FROM products WHERE id='${product.id}'), (SELECT id FROM orders WHERE id='${order.id}'))`, (err, result) => {
                            if(err) console.log(err);
                        })
                    })
                })
            })

        })

    })    
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

function createUser(username, email, password, firstname, lastname, gender, street, housenumber, postcode, cityName, country){  
    con.query(`INSERT INTO users(username, email, password) VALUES ('${username}','${email}','${password}')`, function(err, result){
        if(err){
            console.log(err);
        }else if(result){
            sendQuery(`INSERT INTO userinfos(firstname, lastname, gender, userId) VALUES ('${firstname}','${lastname}','${gender}',
            (SELECT id FROM users WHERE username='${username}' AND email='${email}'))`);
            console.log(`User created: ${username}!`)
    
            sendQuery(`INSERT INTO cities(name, postcode) VALUES ('${cityName}', '${postcode}')`);
    
            sendQuery(`INSERT INTO addresses(street, housenumber, country, userId, cityId) VALUES ('${street}','${housenumber}','${country}',
            (SELECT id FROM users WHERE username='${username}'), (SELECT id FROM cities WHERE name='${cityName}' AND postcode='${postcode}'))`);
        }
    });
}



module.exports = {
    sendQuery, createOrder, createReview,
    createProduct, createCategory, createSeller, createUser, con
}
