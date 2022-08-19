// Importing express module
const express = require("express")
const bodyParser = require('body-parser')

// Creating express router
const router = express.Router()
const { pool } = require('../config')


router.use(bodyParser.json())
router.use(bodyParser.urlencoded({ extended: true }))

// Handling request using router
router.get("/items", (req, res, next) => {
    pool.query('SELECT * FROM items', (error, results) => {
        if (error) {
            throw error
        }
        res.status(200).send(results.rows)
    })
})

router.get("/items/:id", (req, res, next) => {
    const { id } = req.params;
    pool.query('SELECT * FROM items WHERE item_id=$1',
    [id],
    (error, results) => {
        if (error) {
            throw error
        }
        console.log(results)
        res.status(200).send(results.rows)
    })
})


router.post("/items", (req, res, next) => {
    const { item_name, item_description, item_price, item_image_url, item_visible, resturant_id, category_id } = req.body

    pool.query(
        'INSERT INTO items (item_name, item_description, item_price, item_image_url, item_visible, resturant_id, category_id) VALUES ($1, $2, $3, $4, $5, $6, $7)',
        [item_name, item_description, item_price, item_image_url, item_visible, resturant_id, category_id],
        (error) => {
            if (error) {
                throw error
            }
            res.status(201).json({ status: 'success', message: 'Item added.' })
        }
    )
})

router.put("/items/:id", (req, res, next) => {
    const { id } = req.params;
    const { item_name, item_description, item_price, item_image_url, item_visible, resturant_id, category_id } = req.body

    pool.query(
        'UPDATE items SET item_name=$1 , item_description=$2, item_price=$3, item_image_url=$4, item_visible=$5, resturant_id=$6, category_id=$7 WHERE item_id=$8',
        [item_name, item_description, item_price, item_image_url, item_visible, resturant_id, category_id, id],
        (error) => {
            if (error) {
                throw error
            }
            res.status(201).json({ status: 'success', message: 'Item updated.' })
        }
    )
})


router.delete("/items/:id", (req, res, next) => {
    const { id } = req.params;

    pool.query(
        'DELETE FROM items WHERE item_id=$1',
        [id],
        (error) => {
            if (error) {
                throw error
            }
            res.status(204).json({ status: 'success', message: 'Item deleted.' })
        }
    )
})

// Exporting router
module.exports = router