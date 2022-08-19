// Importing express module
const express = require("express")
const bodyParser = require('body-parser')

// Creating express router
const router = express.Router()
const { pool } = require('../config')
router.use(bodyParser.json())
router.use(bodyParser.urlencoded({ extended: true }))

// Handling request using router
router.get("/orders", (req, res, next) => {
    pool.query('SELECT * FROM orders', (error, results) => {
        if (error) {
            throw error
        }
        res.status(200).send(results.rows)
    })
})

router.get("/orders/:id", (req, res, next) => {
    const { id } = req.params;
    pool.query('SELECT * FROM orders WHERE order_id=$1',
    [id],
    (error, results) => {
        if (error) {
            throw error
        }
        console.log(results)
        res.status(200).send(results.rows)
    })
})


router.post("/orders", (req, res, next) => {
    const { order_customer_name, order_customer_phone_number,resturant_id } = req.body

    pool.query(
        'INSERT INTO orders (order_customer_name, order_customer_phone_number,resturant_id) VALUES ($1, $2, $3)',
        [order_customer_name, order_customer_phone_number,resturant_id],
        (error) => {
            if (error) {
                throw error
            }
            res.status(201).json({ status: 'success', message: 'Order added.' })
        }
    )
})

router.put("/orders/:id", (req, res, next) => {
    const { id } = req.params;
    console.log(req.body)
    const { order_customer_name, order_customer_phone_number,resturant_id } = req.body

    pool.query(
        'UPDATE orders SET order_customer_name=$1 , order_customer_phone_number=$2, resturant_id=$3 WHERE order_id=$4',
        [order_customer_name, order_customer_phone_number,resturant_id, id],
        (error) => {
            if (error) {
                throw error
            }
            res.status(201).json({ status: 'success', message: 'Order updated.' })
        }
    )
})

router.delete("/orders/:id", (req, res, next) => {
    const { id } = req.params;

    pool.query(
        'DELETE FROM orders WHERE order_id=$1',
        [id],
        (error) => {
            if (error) {
                throw error
            }
            res.status(204).json({ status: 'success', message: 'Order deleted.' })
        }
    )
})
  
// Exporting router
module.exports = router