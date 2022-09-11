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
    pool
        .query('SELECT * FROM line_items')
        .then(results => res.status(200).send(results.rows))
        .catch(e => console.error(e.stack))
})

router.get("/line_items/:id", (req, res, next) => {
    const { id } = req.params;
    pool
        .query('SELECT * FROM line_items WHERE line_items_id=$1',
            [id])
        .then(results => res.status(200).send(results.rows))
        .catch(e => console.error(e.stack))
})

router.post("/line_items", (req, res, next) => {
    const { line_items_name, line_items_description, line_items_price } = req.body

    pool
        .query('INSERT INTO line_items (line_items_name, line_items_description, line_items_price) VALUES ($1, $2, $3)',
            [line_items_name, line_items_description, line_items_price])
        .then(results => res.status(201).json({ status: 'success', message: 'line_item added.' }))
        .catch(e => console.error(e.stack))
})

router.put("/line_items/:id", (req, res, next) => {
    const { id } = req.params;
    const { line_items_name, line_items_description, line_items_price } = req.body
    pool
        .query('UPDATE line_items SET line_items_name=$1 , line_items_description=$2, line_items_price=$3 WHERE line_items_id=$4',
            [line_items_name, line_items_description, line_items_price, id])
        .then(results => res.status(201).json({ status: 'success', message: 'line_item updated.' }))
        .catch(e => console.error(e.stack))
})


router.delete("/line_items/:id", (req, res, next) => {
    const { id } = req.params;

    pool
        .query('DELETE FROM line_items WHERE line_items_id=$1',
            [id])
        .then(results => res.status(201).json({ status: 'success', message: 'line_item deleted.' }))
        .catch(e => console.error(e.stack))
})

// Exporting router
module.exports = router