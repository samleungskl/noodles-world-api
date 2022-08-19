// Importing express module
const express = require("express")
const bodyParser = require('body-parser')

// Creating express router
const router = express.Router()
const { pool } = require('../config')

router.use(bodyParser.json())
router.use(bodyParser.urlencoded({ extended: true }))

// Handling request using router
router.get("/line_items", (req, res, next) => {
    pool.query('SELECT * FROM line_items', (error, results) => {
        if (error) {
            throw error
        }
        res.status(200).send(results.rows)
    })
})

router.get("/line_items/:id", (req, res, next) => {
    const { id } = req.params;
    pool.query('SELECT * FROM line_items WHERE line_items_id=$1',
    [id],
    (error, results) => {
        if (error) {
            throw error
        }
        console.log(results)
        res.status(200).send(results.rows)
    })
})

router.post("/line_items", (req, res, next) => {
    const { line_items_name, line_items_description, line_items_price } = req.body

    pool.query(
        'INSERT INTO line_items (line_items_name, line_items_description, line_items_price) VALUES ($1, $2, $3)',
        [line_items_name, line_items_description, line_items_price],
        (error) => {
            if (error) {
                throw error
            }
            res.status(201).json({ status: 'success', message: 'line_item added.' })
        }
    )
})

router.put("/line_items/:id", (req, res, next) => {
    const { id } = req.params;
    const { line_items_name, line_items_description, line_items_price } = req.body

    pool.query(
        'UPDATE line_items SET line_items_name=$1 , line_items_description=$2, line_items_price=$3 WHERE line_items_id=$4',
        [line_items_name, line_items_description, line_items_price, id],
        (error) => {
            if (error) {
                throw error
            }
            res.status(201).json({ status: 'success', message: 'line_item updated.' })
        }
    )
})


router.delete("/line_items/:id", (req, res, next) => {
    const { id } = req.params;

    pool.query(
        'DELETE FROM line_items WHERE line_items_id=$1',
        [id],
        (error) => {
            if (error) {
                throw error
            }
            res.status(201).json({ status: 'success', message: 'line_item deleted.' })
        }
    )
})

// Exporting router
module.exports = router