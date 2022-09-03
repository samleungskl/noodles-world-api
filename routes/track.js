// Importing express module
const express = require("express")
const bodyParser = require('body-parser')

// Creating express router
const router = express.Router()
const { pool } = require('../config')
router.use(bodyParser.json())
router.use(bodyParser.urlencoded({ extended: true }))

router.get("/track", (req, res, next) => {
    const { orderPhoneNumber } = req.query;
    console.log('orderPhoneNumber', orderPhoneNumber)
        ; (async () => {
            try {
                const resultOrders = await pool.query('SELECT * FROM orders WHERE order_customer_phone_number=$1', [orderPhoneNumber])
                const idArray = resultOrders.rows.map((element) => {
                    return element.order_id
                });
                let genQuery = ''
                idArray.forEach((element, index) => {
                    genQuery += `$${index + 1}`
                    if (idArray.length - 1 > index) {
                        genQuery += ', '
                    }
                });
                const resultLineItems = await pool.query(`SELECT * FROM line_items WHERE order_id IN (${genQuery})`, idArray)
                const resultArray = resultOrders.rows.map((order) => {
                    console.log('here!')
                    const filteredResult = resultLineItems.rows.filter((lineitem) => order.order_id === lineitem.order_id)
                    order.order_line_items = filteredResult;
                    return order
                })
                console.log('resultArray = ', resultArray)
                res.status(200).json(resultArray);
            } catch (e) {
                console.log('error occured.');
                throw e
            }
        })().catch(e => console.error(e.stack))
})

// Exporting router
module.exports = router